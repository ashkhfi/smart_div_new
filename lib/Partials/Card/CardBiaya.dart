import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget CardBiaya(BuildContext context, {
  required String title, 
  required String total, 
}) {
  return Container(
    height: 80.h,
    width: MediaQuery.of(context).size.width * 0.8,
    decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
              color: Colors.grey,
              spreadRadius: 0.4,
              blurRadius: 2,
              offset: Offset(0, 3.5)),
        ],
        border: Border.all(color: const Color.fromRGBO(2, 138, 234, 1), width: 2.dm),
        borderRadius: BorderRadius.circular(10.dm)),
    child: Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: const Color.fromRGBO(0, 73, 124, 1),
              fontFamily: "Lato",
              fontSize: 16.sp,
            ),
          ),
          Text(
            total,
            style: TextStyle(
                color: const Color.fromRGBO(0, 73, 124, 1),
                fontFamily: "Lato",
                fontSize: 25.sp,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}
