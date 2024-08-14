import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget ItemCard(BuildContext context, {
  required String title, 
  required bool condition,
  required dynamic data
}) {
  return Container(
    height: 120.h,
    width: MediaQuery.of(context).size.width * 0.8,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: const Color.fromRGBO(2, 138, 234, 1), width: 2.dm),
      borderRadius: BorderRadius.circular(10.dm),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40.h,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(2, 138, 234, 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.dm),
                  topRight: Radius.circular(5.dm))),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Text(
                  title,
                  style: TextStyle(
                      fontFamily: "Lato",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 22.h,
                    decoration: BoxDecoration(
                        color: (condition)? const Color.fromRGBO(231, 255, 245, 1) : const Color.fromRGBO(255, 231, 231,1),
                        borderRadius: BorderRadius.circular(10.dm)),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 2.dm, bottom: 2.dm, left: 5.dm, right: 5.dm),
                      child: Center(
                        child: Text(
                          (condition)? "Active" : "Inactive",
                          style: TextStyle(
                              fontFamily: "Lato",
                              fontSize: 14.sp,
                              color: (condition)? const Color.fromRGBO(19, 169, 124, 1) : const Color.fromRGBO(255, 67, 67,1) ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),

        /**
         * 
         * note: edit bagian ini sesuaikan dengan data dari firebase.
         */
        Padding(
          padding: EdgeInsets.only(left:10.w),
          child: Column(
            children: [
              Text(
                "Vrs: 110V",
                style: TextStyle(
                    fontFamily: "Lato",
                    fontSize: 16.sp,
                    color: const Color.fromRGBO(2, 138, 234, 1)),
              ),
              Text(
                "Vst: 110V",
                style: TextStyle(
                    fontFamily: "Lato",
                    fontSize: 16.sp,
                    color: const Color.fromRGBO(2, 138, 234, 1)),
              ),
              Text(
                "Vtr: 110V",
                style: TextStyle(
                    fontFamily: "Lato",
                    fontSize: 16.sp,
                    color: const Color.fromRGBO(2, 138, 234, 1)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
