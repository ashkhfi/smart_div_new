import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:smart_div_new/Provider/wheater_provider.dart';
import 'package:weather_icons/weather_icons.dart';

import '../Partials/Button/BackButton.dart';

class Cuaca extends StatefulWidget {
  const Cuaca({super.key});

  @override
  _CuacaState createState() => _CuacaState();
}

class _CuacaState extends State<Cuaca> {
  @override
  void initState() {
    super.initState();
  }

  String translateWeatherDescription(String description) {
    switch (description.toLowerCase()) {
      case 'clear sky':
        return 'Langit Cerah';
      case 'few clouds':
        return 'Sedikit Berawan';
      case 'scattered clouds':
        return 'Berawan Tersebar';
      case 'broken clouds':
        return 'Berawan Pecah';
      case 'shower rain':
        return 'Hujan Gerimis';
      case 'rain':
        return 'Hujan';
      case 'thunderstorm':
        return 'Badai Petir';
      case 'snow':
        return 'Salju';
      case 'mist':
        return 'Kabut';
      case 'smoke':
        return 'Asap';
      case 'haze':
        return 'Kabut Asap';
      case 'fog':
        return 'Kabut';
      case 'dust':
      return 'Debu';
      case 'sand':
        return 'Pasir';
      case 'ash':
        return 'Abu';
      case 'squall':
        return 'Angin Kencang';
      case 'tornado':
        return 'Tornado';
      default:
        return description;
    }
  }

  IconData translateWeatherIcon(String description) {
    switch (description.toLowerCase()) {
      case 'clear sky':
        return WeatherIcons.day_sunny;
      case 'few clouds':
        return WeatherIcons.day_cloudy;
      case 'scattered clouds':
        return WeatherIcons.cloud;
      case 'broken clouds':
        return WeatherIcons.cloudy;
      case 'shower rain':
        return WeatherIcons.showers;
      case 'rain':
        return WeatherIcons.rain;
      case 'thunderstorm':
        return WeatherIcons.thunderstorm;
      case 'snow':
        return WeatherIcons.snow;
      case 'mist':
      case 'fog':
        return WeatherIcons.fog;
      case 'smoke':
        return WeatherIcons.smoke;
      case 'haze':
        return WeatherIcons.day_haze;
      case 'dust':
      case 'sand':
        return WeatherIcons.sandstorm;
      case 'ash':
        return WeatherIcons.volcano;
      case 'squall':
        return WeatherIcons.strong_wind;
      case 'tornado':
        return WeatherIcons.tornado;
      default:
        return WeatherIcons.cloud;
    }
  }

  Color translateWeatherColor(String description) {
    switch (description.toLowerCase()) {
      case 'clear sky':
        return Colors.amber;
      case 'few clouds':
        return Colors.grey;
      case 'scattered clouds':
        return Colors.blueGrey;
      case 'broken clouds':
        return Colors.grey;
      case 'shower rain':
        return Colors.lightBlue;
      case 'rain':
        return Colors.blue;
      case 'thunderstorm':
        return Colors.deepPurple;
      case 'snow':
        return Colors.lightBlueAccent;
      case 'mist':
      case 'fog':
      case 'haze':
        return Colors.white70;
      case 'smoke':
        return Colors.brown;
      case 'dust':
      case 'sand':
      case 'ash':
        return Colors.orange;
      case 'squall':
        return Colors.teal;
      case 'tornado':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);
    if (provider.weatherData == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(), // Menampilkan indikator loading
        ),
      );
    }

    String currentDate =
        DateFormat('EEEE, dd MMMM yyyy', "id_ID").format(DateTime.now());
    String currentTime = DateFormat('HH:mm').format(DateTime.now());
    String weatherDescription =
        translateWeatherDescription(provider.weatherData!.weather.description);
    IconData weatherIcon =
        translateWeatherIcon(provider.weatherData!.weather.description);
    Color weatherColor =
        translateWeatherColor(provider.weatherData!.weather.description);

    return Scaffold(
      body: Consumer<WeatherProvider>(
        builder: (context, value, child) {
          return Column(
            children: [
              SizedBox(
                height: 40.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 60.w),
                    child: KembaliButton(context, onTap: () {
                      Navigator.pop(context);
                    }),
                  ),
                  Center(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Perkiraan Cuaca",
                        style: TextStyle(
                            fontFamily: "Lato",
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Text("Kota Semarang",
                  style: TextStyle(
                      fontFamily: "Lato",
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(0, 73, 124, 1))),
              SizedBox(
                height: 10.h,
              ),
              Text(
                  "${provider.weatherData?.main.temp.toStringAsFixed(0) ?? "0"} ℃",
                  style: TextStyle(
                      fontFamily: "Lato",
                      fontSize: 40.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(0, 73, 124, 1))),
              SizedBox(
                height: 10.h,
              ),
              Text(weatherDescription,
                  style: TextStyle(
                      fontFamily: "Lato",
                      fontSize: 22.sp,
                      fontWeight: FontWeight.normal,
                      color: const Color.fromRGBO(0, 73, 124, 1))),
              SizedBox(
                height: 20.h,
              ),
              Text(currentDate,
                  style: TextStyle(
                      fontFamily: "Lato",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.normal,
                      color: const Color.fromRGBO(0, 73, 124, 1))),
              SizedBox(
                height: 10.h,
              ),
              Text(currentTime,
                  style: TextStyle(
                      fontFamily: "Lato",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.normal,
                      color: const Color.fromRGBO(0, 73, 124, 1))),
              SizedBox(
                height: 50.h,
              ),
              Center(
                child: Icon(
                  weatherIcon,
                  color: weatherColor,
                  size: 150.dm,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 90.h,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(2, 138, 234, 1),
                    borderRadius: BorderRadius.circular(10.dm)),
                child: Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //angin
                      Column(
                        children: [
                          Text(
                            "Angin",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Lato",
                              fontSize: 16.sp,
                            ),
                          ),
                          Icon(
                            LucideIcons.wind,
                            color: Colors.white,
                            size: 30.dm,
                          ),
                          Text(
                            "${provider.weatherData!.wind.speed.toString()} km/h",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Lato",
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),

                      //kelembaban
                      Column(
                        children: [
                          Text(
                            "Kelembaban",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Lato",
                              fontSize: 16.sp,
                            ),
                          ),
                          Icon(
                            LucideIcons.droplet,
                            color: Colors.white,
                            size: 30.dm,
                          ),
                          Text(
                            "${provider.weatherData!.main.humidity.toString()} %",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Lato",
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),

                      //suhu maks
                      Column(
                        children: [
                          Text(
                            "Suhu maks",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Lato",
                              fontSize: 16.sp,
                            ),
                          ),
                          Icon(
                            LucideIcons.thermometerSun,
                            color: Colors.white,
                            size: 30.dm,
                          ),
                          Text(
                            "${provider.weatherData!.main.tempMax.toStringAsFixed(0)} ℃",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Lato",
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}