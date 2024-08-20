import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget BaseCard(BuildContext context, {
  required double height,
  required double width,
  required Widget widget}) {
  return SizedBox(
    height: height,
    width: width,
    child: Stack(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              boxShadow: const [BoxShadow(color: Colors.grey, spreadRadius: 0.7)],
              color: const Color.fromRGBO(2, 138, 234, 1),
              borderRadius: BorderRadius.circular(10.dm)),
        ),
        widget
      ],
    ),
  );
}
