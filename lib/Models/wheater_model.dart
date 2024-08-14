class WeatherModel {
  final String main;
  final String description;
  final String icon;

  WeatherModel({
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'main': main,
      'description': description,
      'icon': icon,
    };
  }
}

class MainModel {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;

  MainModel({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  factory MainModel.fromJson(Map<String, dynamic> json) {
    return MainModel(
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      tempMin: json['temp_min'].toDouble(),
      tempMax: json['temp_max'].toDouble(),
      pressure: json['pressure'],
      humidity: json['humidity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temp': temp,
      'feels_like': feelsLike,
      'temp_min': tempMin,
      'temp_max': tempMax,
      'pressure': pressure,
      'humidity': humidity,
    };
  }
}

class WindModel {
  final double speed;
  final int deg;

  WindModel({
    required this.speed,
    required this.deg,
  });

  factory WindModel.fromJson(Map<String, dynamic> json) {
    return WindModel(
      speed: json['speed'].toDouble(),
      deg: json['deg'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'speed': speed,
      'deg': deg,
    };
  }
}

class WeatherDataModel {
  final WeatherModel weather;
  final MainModel main;
  final WindModel wind;

  WeatherDataModel({
    required this.weather,
    required this.main,
    required this.wind,
  });

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) {
    return WeatherDataModel(
      weather: WeatherModel.fromJson(json['weather'][0]),
      main: MainModel.fromJson(json['main']),
      wind: WindModel.fromJson(json['wind']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'weather': weather.toJson(),
      'main': main.toJson(),
      'wind': wind.toJson(),
    };
  }
}
