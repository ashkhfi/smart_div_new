import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:smart_div_new/Provider/wheater_provider.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<WeatherProvider>(context, listen: false);
      provider.fetchWeather();
    });
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
      default:
        return description; // Jika tidak ada terjemahan, gunakan deskripsi asli
    }
  }

  IconData translateWeatherIcon(String description) {
    switch (description.toLowerCase()) {
      case 'clear sky':
        return Icons.wb_sunny;
      case 'few clouds':
        return Icons.cloud;
      case 'scattered clouds':
        return Icons.cloud_queue;
      case 'broken clouds':
        return Icons.cloud_off;
      case 'shower rain':
        return Icons.grain;
      case 'rain':
        return Icons.beach_access;
      case 'thunderstorm':
        return Icons.flash_on;
      case 'snow':
        return Icons.ac_unit;
      case 'mist':
        return Icons.blur_on;
      default:
        return Icons.help; // Ikon default jika tidak ada yang cocok
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
        return Colors.white70;
      default:
        return Colors.black; // Warna default jika tidak ada yang cocok
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);
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
      body: Column(
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
          Text("${provider.weatherData?.main.temp.toStringAsFixed(0) ?? "0"} ℃",
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
            height: 10.h,
          ),
          Icon(
            weatherIcon,
            color: weatherColor,
            size: 200.dm,
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

                  //kelembaban
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
      ),
    );
  }
}
