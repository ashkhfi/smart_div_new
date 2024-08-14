import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget BaseButton(BuildContext context, {
  required double height, 
  required double width,
  required String label,
  required Color color,
  required Color fontColor,
  required void Function() onTap,
  double borderRadius = 0
}){
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
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Padding(padding: EdgeInsets.all(5.dm), 
          child: Text(label, style: TextStyle(
            color: fontColor,
            fontFamily: "Lato",
            fontSize: 14.sp  
          ),),),
        ),
      ),
    ),
  );
}