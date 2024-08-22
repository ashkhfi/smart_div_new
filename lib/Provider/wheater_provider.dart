import 'dart:async';
import 'package:flutter/material.dart';

import '../Models/wheater_model.dart';
import '../Services/wheater_service.dart'; // Ganti dengan path ke model Anda

class WeatherProvider with ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  WeatherDataModel? _weatherData;
  bool _isLoading = false;
  String? _errorMessage;

  WeatherDataModel? get weatherData => _weatherData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  WeatherProvider() {
    _startFetchingWeather();
  }

  void _startFetchingWeather() async{
    
      await fetchWeatherData();
    
  }

  Future<void> fetchWeatherData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await _weatherService.fetchWeatherData();
      _weatherData = data;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
