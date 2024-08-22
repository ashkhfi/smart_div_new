import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/wheater_model.dart';

class WeatherService {
  String apiUrl =
      'http://api.openweathermap.org/data/2.5/weather?q=Semarang,id&APPID=c132a8faae5a9ec38529b91df9ee0815&units=metric';

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

  Stream<WeatherDataModel?> getWeatherStream(Duration interval) async* {
    while (true) {
      yield await fetchWeatherData();
      await Future.delayed(interval);
    }
  }
}
