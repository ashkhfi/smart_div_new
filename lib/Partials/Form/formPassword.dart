import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget FormPassword(BuildContext context,
    {required String label,
    required TextEditingController controller,
    bool isKonf = false,
    TextEditingController? sibling,
    required RxBool isVisible}) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.9,
    decoration: BoxDecoration(
        color: const Color.fromARGB(255, 240, 240, 240),
        borderRadius: BorderRadius.circular(10.dm)),
    child: TextFormField(
      controller: controller,
      obscuringCharacter: "*",
      obscureText: isVisible.value,
      style:
          TextStyle(fontFamily: "Lato", color: Colors.black, fontSize: 14.sp),
      decoration: InputDecoration(
        isDense: true,
        hintText: "******",
        disabledBorder: const OutlineInputBorder(
            gapPadding: 0, borderRadius: BorderRadius.zero),
        suffixIcon: IconButton(
            onPressed: () {
              isVisible.value = !isVisible.value;
            },
            icon: (isVisible.value)
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off)),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(3.dm)),
      ),
      validator: (String? sr) {
        if (sr!.isEmpty) {
          return "field $label tidak boleh kosong!";
        }

        if (isKonf == true) {
          if (sr.isEmpty || sibling!.text != sr) {
            return "password tidak sesuai";
          }
        }
        return null;
      },
    ),
  );
}