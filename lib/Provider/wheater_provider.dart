import 'package:flutter/material.dart';
import '../Models/wheater_model.dart';
import '../Services/wheater_service.dart';

class WeatherProvider with ChangeNotifier {
  WeatherDataModel? _weatherData;
  bool _isLoading = false;
  String? _errorMessage;

  WeatherDataModel? get weatherData => _weatherData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final WeatherService _weatherService = WeatherService();

  Future<void> fetchWeather() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final data = await _weatherService.fetchWeatherData();
      if (data != null) {
        _weatherData = data;
      } else {
        _errorMessage = 'Failed to load weather data';
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}