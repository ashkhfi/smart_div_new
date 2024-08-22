import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smart_div_new/Provider/auth_provider.dart';

import '../Partials/Button/BackButton.dart';
import '../Partials/Button/BaseButton.dart';
import '../Partials/Form/formText.dart';

class LupaPass extends StatefulWidget {
  const LupaPass({super.key});

  @override
  _LupaPassState createState() => _LupaPassState();
}

class _LupaPassState extends State<LupaPass> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 40.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 40.w),
                child: KembaliButton(context, onTap: () {
                  Navigator.pop(context);
                }),
              ),
              Center(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Atur Ulang Password",
                    style: TextStyle(
                        fontFamily: "Lato",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromRGBO(0, 73, 124, 1)),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Kami akan mengirimkan link\nKonfirmasi ke email Anda",
                style: TextStyle(
                    color: const Color.fromRGBO(0, 73, 124, 1),
                    fontFamily: "Lato",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          //field email
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "EMAIL",
                style: TextStyle(
                    color: Colors.grey, fontFamily: "Lato", fontSize: 14.sp),
              ),
              SizedBox(
                height: 5.h,
              ),
              FormText(context, controller: emailController, label: "EMAIL"),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          /*
                tombol untuk update password
              */
          BaseButton(context,
              height: 40.h,
              width: MediaQuery.of(context).size.width * 0.9,
              color: const Color.fromRGBO(2, 138, 234, 1),
              fontColor: Colors.white,
              label: "Kirim",
              borderRadius: 10.dm, onTap: () async {
            /*
                      function untuk simpan data di sini
                    */
            if (emailController.text.isNotEmpty) {
              await authProvider.resetPassword(emailController.text);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password Reset link Terkirim!')),
              );
            }
          }),
          if (authProvider.errorMessage != null)
            Text(
              authProvider.errorMessage.toString(),
              style: TextStyle(
                  color: Colors.red,
                  fontFamily: "Lato",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}
