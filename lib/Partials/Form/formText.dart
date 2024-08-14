import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget FormText(BuildContext context,
    {required String label,
    required TextEditingController controller,
    TextInputType type = TextInputType.text,
    int maxline = 1}) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.9,
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 240, 240, 240), 
      borderRadius: BorderRadius.circular(10.dm)
    ),
    child: TextFormField(
      controller: controller,
      keyboardType: type,
      maxLines: maxline,
      style: TextStyle(fontFamily: "Lato", color: Colors.black, fontSize: 14.sp),
      decoration: InputDecoration(
        isDense: true,
        hintText: "user@gmail.com",
        disabledBorder: const OutlineInputBorder(
            gapPadding: 0, borderRadius: BorderRadius.zero),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(3.dm)),
      ),
      validator: (String? sr) {
        if (sr!.isEmpty) {
          return "field $label tidak boleh kosong!";
        }
        return null;
      },
    ),
  );
}