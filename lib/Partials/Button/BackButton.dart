import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget KembaliButton(
  BuildContext context, {
  required Function() onTap,
}) {
  return Container(
    height: 30.dm,
    width: 30.dm,
    decoration: BoxDecoration(
        color: const Color.fromRGBO(2, 138, 234, 1),
        borderRadius: BorderRadius.circular(10.dm)),
    child: Center(
      child: IconButton(
          onPressed: onTap,
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 15,
          )),
    ),
  );
}
