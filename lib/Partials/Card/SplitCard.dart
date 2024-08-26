import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../Provider/sensor_provider.dart';

Widget SplitCard(BuildContext context) {
     final sensorProvider = Provider.of<SensorProvider>(context);
  return Container(
    width: MediaQuery.of(context).size.width * 0.9,
    height: 120.h,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Color.fromRGBO(2, 138, 234, 1)),
      borderRadius: BorderRadius.circular(20.dm),
      boxShadow: [
        BoxShadow(color: const Color.fromARGB(255, 111, 155, 191), blurRadius: 10.h, spreadRadius: 2.h)
      ]
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            Padding(
              padding: EdgeInsets.only(left:10.w),
              child: Text(
                "Mode",
                style: TextStyle(
                  color: Color.fromRGBO(0, 73, 124, 1),
                  fontFamily: "Lato",
                  fontSize: 20.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right:10.w),
              child: Text(
                sensorProvider.sensor?.mode ?? "-",
                style: TextStyle(
                    color: Color.fromRGBO(0, 73, 124, 1),
                    fontFamily: "Lato",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            
          ],
        ),
        Divider(
          color: Color.fromRGBO(2, 138, 234, 1),
          thickness: 3.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          
            Padding(
              padding: EdgeInsets.only(left:10.w),
              child: Text(
                "Sumber Aktif",
                style: TextStyle(
                  color: Color.fromRGBO(0, 73, 124, 1),
                  fontFamily: "Lato",
                  fontSize: 20.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right:10.w),
              child: Text(
                sensorProvider.sensor?.sumber ?? "",
                style: TextStyle(
                    color: Color.fromRGBO(0, 73, 124, 1),
                    fontFamily: "Lato",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            
          ],
        ),
      ],
    ),
  );
}