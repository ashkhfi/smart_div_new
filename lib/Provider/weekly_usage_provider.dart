import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Models/weekly_usage_model.dart';
import '../Services/weekly_usage_service.dart'; // Pastikan pathnya sesuai dengan project Anda

class WeeklyUsageProvider with ChangeNotifier {
  final WeeklyUsageService _service = WeeklyUsageService();

  List<WeeklyUsage> _weeklyUsages = [];
  List<WeeklyUsage> _allweeklyUsages = [];
  bool _isLoading = false;
  String? _errorMessage;
  bool _hasNextPage = true;
  bool _hasPreviousPage = false;
  DocumentSnapshot? _lastDocument;
  int _currentPage = 0;
  int _totalPages = 0;
  int limit = 7;
  List<WeeklyUsage> get weeklyUsages => _weeklyUsages;
  List<WeeklyUsage> get allweeklyUsages => _allweeklyUsages;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasNextPage => _hasNextPage;
  bool get hasPreviousPage => _hasPreviousPage;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;

  WeeklyUsageProvider() {
    getAllData();
  }

  Future<void> getAllData() async {
    _isLoading = true;
    notifyListeners();
    try {
      _allweeklyUsages = await _service.getAllData();
    } catch (e) {
      _errorMessage = 'Error fetching data: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchFirstPage() async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _service.getAllDataPagination(page: 1, limit: limit);
      _weeklyUsages = result['data'] as List<WeeklyUsage>;
      _hasNextPage = result['hasMore'] as bool;
      _hasPreviousPage = false;
      _lastDocument = result['lastDocument'] as DocumentSnapshot?;
      _currentPage = 1;
      _totalPages = result['totalPages'] as int; // Set total halaman
      print(
          "Current Page: $_currentPage, Data Count: ${_weeklyUsages.length}, Has Next Page: $_hasNextPage, Has Prev Page: $_hasPreviousPage");
    } catch (e) {
      _errorMessage = 'Error fetching data: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchNextPage() async {
    if (!_hasNextPage) return;

    // _isLoading = true;
    notifyListeners();

    try {
      final result = await _service.getAllDataPagination(
        page: _currentPage + 1,
        limit: limit,
        startAfter:
            _lastDocument, // Mulai mengambil data setelah dokumen terakhir dari halaman sebelumnya
      );

      final newData = result['data'] as List<WeeklyUsage>;
      if (newData.isNotEmpty) {
        _weeklyUsages.clear();
        _weeklyUsages.addAll(newData); // Tambahkan data baru ke dalam list
      }

      _hasNextPage = result['hasMore'] as bool;
      _currentPage++; // Update halaman saat ini
      _hasPreviousPage = _currentPage > 1;
      _lastDocument = result['lastDocument'] as DocumentSnapshot?;

      print(
          "Current Page: $_currentPage, Data Count: ${_weeklyUsages.length}, Has Next Page: $_hasNextPage, Has Prev Page: $_hasPreviousPage");
    } catch (e) {
      _errorMessage = 'Error fetching data: $e';
    } finally {
      // _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPreviousPage() async {
    if (!_hasPreviousPage) return;

    // _isLoading = true;
    notifyListeners();

    try {
      final result = await _service.getAllDataPagination(
        page: _currentPage - 1,
        limit: limit,
        startAfter:
            null, // Implementasi untuk halaman sebelumnya perlu menyesuaikan cara penyimpanan state
      );
      _weeklyUsages = result['data'] as List<WeeklyUsage>;
      _hasNextPage = true; // Bisa ada halaman berikutnya
      _currentPage--; // Turunkan halaman saat ini
      _hasPreviousPage =
          _currentPage > 1; // Ada halaman sebelumnya jika currentPage > 1
      _lastDocument = result['lastDocument'] as DocumentSnapshot?;

      print(
          "Current Page: $_currentPage, Data Count: ${_weeklyUsages.length}, Has Next Page: $_hasNextPage, Has Prev Page: $_hasPreviousPage");
    } catch (e) {
      _errorMessage = 'Error fetching data: $e';
    } finally {
      // _isLoading = false;
      notifyListeners();
    }
  }
}
