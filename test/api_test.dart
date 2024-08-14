

import 'package:flutter_test/flutter_test.dart';
import 'package:smart_div_new/Services/api_service.dart';

void main() {
  group('WeatherService Print Test', () {
    test('Print the weather data response from real API', () async {
      final weatherService = WeatherService();
      weatherService.apiUrl = 'http://api.openweathermap.org/data/2.5/weather?q=Semarang,id&APPID=c132a8faae5a9ec38529b91df9ee0815&units=metric';

      final weatherData = await weatherService.fetchWeatherData();

      // Print the response
      if (weatherData != null) {
        print('Weather: ${weatherData.weather.main}, Temp: ${weatherData.main.temp}°C, Wind Speed: ${weatherData.wind.speed} m/s');
      } else {
        print('Failed to fetch weather data');
      }
    });
  });
}
