import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:smart_div_new/View/Login.dart';

import '../Partials/Button/BaseButton.dart';
import '../Partials/Form/formPassword.dart';
import '../Partials/Form/formText.dart';
import '../Provider/auth_provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _konfController = TextEditingController();

  // Untuk kondisi visibilitas password
  RxBool isVisible = true.obs;
  RxBool isVisible2 = true.obs;

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("Loading..."),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSuccessMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<void> _registerUser() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    print("1");
    if (_passController.text == _konfController.text) {
      _showLoadingDialog(context);

      try {
        await authProvider.signUp(
          _emailController.text.trim(),
          _passController.text.trim(),
        );
        Navigator.of(context).pop(); // close loading dialog
        _showSuccessMessage(context, "Registration successful");
        Get.offAll(() => const Login()); // Redirect to login page
      } catch (e) {
        Navigator.of(context).pop(); // close loading dialog
        _showErrorMessage(context, e.toString());
      }
    } else {
      _showErrorMessage(context, "Password and confirmation do not match");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 70.h),

            Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Buat Akun",
                style: TextStyle(
                  fontFamily: "Lato",
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(0, 73, 124, 1),
                ),
              ),
            ),
            SizedBox(height: 30.h),

            // Field email
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "EMAIL",
                  style: TextStyle(
                      color: Colors.grey, fontFamily: "Lato", fontSize: 14.sp),
                ),
                SizedBox(height: 5.h),
                FormText(context, controller: _emailController, label: "EMAIL"),
              ],
            ),
            SizedBox(height: 10.h),

            // Field password
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PASSWORD",
                  style: TextStyle(
                      color: Colors.grey, fontFamily: "Lato", fontSize: 14.sp),
                ),
                SizedBox(height: 5.h),
                Obx(() => FormPassword(
                      context,
                      label: "PASSWORD",
                      controller: _passController,
                      isVisible: isVisible,
                    )),
              ],
            ),
            SizedBox(height: 10.h),

            // Field password confirmation
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PASSWORD CONFIRMATION",
                  style: TextStyle(
                      color: Colors.grey, fontFamily: "Lato", fontSize: 14.sp),
                ),
                SizedBox(height: 5.h),
                Obx(() => FormPassword(
                      context,
                      label: "PASSWORD CONFIRMATION",
                      isKonf: true,
                      controller: _konfController,
                      isVisible: isVisible2,
                    )),
              ],
            ),
            SizedBox(height: 40.h),

            // Tombol untuk sign up
            BaseButton(
              context,
              height: 40.h,
              width: MediaQuery.of(context).size.width * 0.9,
              color: const Color.fromRGBO(2, 138, 234, 1),
              fontColor: Colors.white,
              label: "Sign Up",
              borderRadius: 10.dm,
              onTap: _registerUser,
            ),
            SizedBox(height: 20.h),

            SizedBox(height: 15.h),
          ],
        ),
      ),
    );
  }
}
