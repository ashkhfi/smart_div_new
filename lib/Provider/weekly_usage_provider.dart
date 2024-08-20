import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Models/weekly_usage_model.dart';
import '../Services/weekly_usage_service.dart'; // Pastikan pathnya sesuai dengan project Anda

class WeeklyUsageProvider with ChangeNotifier {
  final WeeklyUsageService _service = WeeklyUsageService();

  List<WeeklyUsage> _weeklyUsages = [];
  bool _isLoading = false;
  String? _errorMessage;
  bool _hasNextPage = true;
  bool _hasPreviousPage = false;
  DocumentSnapshot? _lastDocument;
  int _currentPage = 0; 
  int _totalPages = 0; 

  List<WeeklyUsage> get weeklyUsages => _weeklyUsages;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasNextPage => _hasNextPage;
  bool get hasPreviousPage => _hasPreviousPage;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;

  Future<void> fetchFirstPage() async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _service.getAllDataPagination(page: 1, limit: 10);
      _weeklyUsages = result['data'] as List<WeeklyUsage>;
      _hasNextPage = result['hasMore'] as bool;
      _hasPreviousPage = false; // Tidak ada halaman sebelumnya saat di halaman pertama
      _lastDocument = result['lastDocument'] as DocumentSnapshot?;
      _currentPage = 1; // Set halaman saat ini ke 1
      _totalPages = result['totalPages'] as int; // Set total halaman
    } catch (e) {
      _errorMessage = 'Error fetching data: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchNextPage() async {
    if (!_hasNextPage) return;

    _isLoading = true;
    notifyListeners();

    try {
      final result = await _service.getAllDataPagination(
        page: _currentPage + 1, 
        limit: 10,
        startAfter: _lastDocument,
      );
      _weeklyUsages.addAll(result['data'] as List<WeeklyUsage>);
      _hasNextPage = result['hasMore'] as bool;
      _hasPreviousPage = _currentPage > 1; // Ada halaman sebelumnya jika currentPage > 1
      _lastDocument = result['lastDocument'] as DocumentSnapshot?;
      _currentPage++; // Naikkan halaman saat ini
    } catch (e) {
      _errorMessage = 'Error fetching data: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPreviousPage() async {
    if (!_hasPreviousPage) return;

    _isLoading = true;
    notifyListeners();

    try {
      final result = await _service.getAllDataPagination(
        page: _currentPage - 1, 
        limit: 10,
        startAfter: null, // Implementasi untuk halaman sebelumnya perlu menyesuaikan cara penyimpanan state
      );
      _weeklyUsages = result['data'] as List<WeeklyUsage>;
      _hasNextPage = true; // Bisa ada halaman berikutnya
      _hasPreviousPage = _currentPage > 1; // Ada halaman sebelumnya jika currentPage > 1
      _lastDocument = result['lastDocument'] as DocumentSnapshot?;
      _currentPage--; // Turunkan halaman saat ini
    } catch (e) {
      _errorMessage = 'Error fetching data: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
