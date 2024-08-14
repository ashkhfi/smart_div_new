import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget GoogleButton(BuildContext context,
    {required double height,
    required double width,
    required String label,
    required Color color,
    required Color fontColor,
    required void Function() onTap,
    double borderRadius = 0}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      splashColor: Colors.grey,
      focusColor: Colors.grey,
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(2, 138, 234, 1),width: 2.w),
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(5.dm),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 40.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 30.dm,
                      width: 30.dm,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/google2.webp"),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right:MediaQuery.of(context).size.width * 0.2),
                    child: Text(
                      label,
                      style: TextStyle(
                          color: fontColor, fontFamily: "Lato", fontSize: 14.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}