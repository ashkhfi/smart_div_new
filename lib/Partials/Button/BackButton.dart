import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget KembaliButton(
  BuildContext context, {
  required Function() onTap,
  Color? iconColor = Colors.white, 
  Color? backgroundColor
}) {
  return Container(
    height: 30.dm,
    width: 30.dm,
    decoration: BoxDecoration(
        color: (backgroundColor == null)?Color.fromRGBO(2, 138, 234, 1) : backgroundColor,
        borderRadius: BorderRadius.circular(10.dm)),
    child: Padding(
      padding: EdgeInsets.only(left:3.w),
      child: Align(
        alignment: Alignment.center,
        child: IconButton(
            onPressed: onTap,
            icon: Icon(
              Icons.arrow_back_ios,
              color: iconColor,
              size: 15,
            )),
      ),
    ),
  );
}