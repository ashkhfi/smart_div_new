import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

Widget PercentBar(BuildContext context, {
  required double percent, 
  required String money
}) {
  
  return CircularPercentIndicator(
    radius: 90.dm,
    curve: Curves.easeIn,
    circularStrokeCap: CircularStrokeCap.round,
    percent: percent / 100,
    lineWidth: 20.dm,
    linearGradient: const LinearGradient(colors: [
      Color.fromRGBO(77, 178, 250, 1),
      Color.fromRGBO(2, 138, 234, 1),
    ]),
    center: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${percent.toStringAsFixed(2)} %",
            style: TextStyle(
                color: const Color.fromRGBO(0, 73, 124, 1),
                fontFamily: "Lato",
                fontWeight: FontWeight.bold,
                fontSize: 28.sp),
          ),
          Text(
            money,
            style: TextStyle(
                color: const Color.fromRGBO(0, 73, 124, 1),
                fontFamily: "Lato",
                fontSize: 16.sp),
          ),
        ],
      ),
    ),
  );
}
