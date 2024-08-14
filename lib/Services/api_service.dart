import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/wheater_model.dart';


class WeatherService {
String apiUrl = '';

  Future<WeatherDataModel?> fetchWeatherData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return WeatherDataModel.fromJson(data);
      } else {
        print('Failed to load weather data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
