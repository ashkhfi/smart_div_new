import 'package:flutter/material.dart';

import '../Models/sensor_model.dart';
import '../Services/weekly_usage_service.dart';

class ExpenseProvider with ChangeNotifier {
  final WeeklyUsageService _usageService = WeeklyUsageService();

  int? thisWeekUsage;
  int? normalUsage;
  int? savings;
  double? percentage;
  sensorModel? _sensor;
  sensorModel? get sensor => _sensor;
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  ExpenseProvider() {
    loadData();
  }

  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Tangani nilai NaN
      var plnUsage = await _usageService.getTotalPLNUsageLast7Days();
      var reUsage = await _usageService.getTotalREusageLast7Days();

      // Calculate and set the variables
      thisWeekUsage = (plnUsage * 1699).toInt();
      normalUsage = ((plnUsage + reUsage) * 1699).toInt();
      savings = (normalUsage! - thisWeekUsage!);

      double totalPenggunaan = reUsage + plnUsage;
      double persentaseRE = (reUsage / totalPenggunaan) * 100;
      double persentasePLN = (plnUsage / totalPenggunaan) * 100;
      percentage = (persentaseRE + persentasePLN) / 2;

      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to load data';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
