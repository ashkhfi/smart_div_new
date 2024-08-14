
import 'package:flutter/material.dart';
import '../Models/weekly_usage_model.dart';
import '../Services/weekly_usage_service.dart';



class WeeklyUsageProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<WeeklyUsage> _weeklyUsages = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<WeeklyUsage> get weeklyUsages => _weeklyUsages;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  
  Future<void> fetchWeeklyUsage() async {
    _isLoading = true;
    notifyListeners();

    try {
      _weeklyUsages = await _firestoreService.getAllData();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to load data: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
