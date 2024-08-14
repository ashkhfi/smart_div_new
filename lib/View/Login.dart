import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:smart_div_new/View/Home.dart';

import '../Partials/Button/BaseButton.dart';
import '../Partials/Button/GoogleButton.dart';
import '../Partials/Form/formPassword.dart';
import '../Partials/Form/formText.dart';
import '../Provider/auth_provider.dart';
import 'Register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  RxBool isVisible = true.obs;
  GlobalKey<FormState> global_key = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 70.h,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Sign In",
                style: TextStyle(
                    fontFamily: "Lato",
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(0, 73, 124, 1)),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
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
                FormText(context, controller: _emailController, label: "EMAIL"),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PASSWORD",
                  style: TextStyle(
                      color: Colors.grey, fontFamily: "Lato", fontSize: 14.sp),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Obx(() => FormPassword(context,
                    label: "PASSWORD",
                    controller: _passwordController,
                    isVisible: isVisible))
              ],
            ),
            SizedBox(
              height: 40.h,
            ),
            BaseButton(context,
                height: 40.h,
                width: MediaQuery.of(context).size.width * 0.9,
                color: const Color.fromRGBO(2, 138, 234, 1),
                fontColor: Colors.white,
                label: "Sign In",
                borderRadius: 10.dm, onTap: () async {
              _showLoadingDialog(context); // Tampilkan dialog loading

              bool success = await authProvider.signIn(
                _emailController.text,
                _passwordController.text,
              );

              Navigator.of(context).pop(); // Tutup dialog loading

              if (success) {
                _showSuccessMessage(context, "Login berhasil!"); // Tampilkan pesan berhasil
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              } else if (authProvider.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      authProvider.errorMessage!.toString(),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Divider(
                        height: 1.h,
                        color: Colors.grey,
                      )),
                  Text(
                    "Or",
                    style: TextStyle(
                        color: const Color.fromRGBO(0, 73, 124, 1),
                        fontFamily: "Lato",
                        fontSize: 12.sp),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Divider(
                        height: 1.h,
                        color: Colors.grey,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          GoogleButton(context,
                    height: 40.h,
                    width: MediaQuery.of(context).size.width * 0.9,
                    color: Colors.white,
                    fontColor: const Color.fromRGBO(0, 73, 124, 1),
                    label: "Google Authentication",
                    borderRadius: 10.dm, onTap: () async {
                    _showLoadingDialog(context); // Tampilkan dialog loading

                    await authProvider.signInWithGoogle();
                    Navigator.of(context).pop(); // Tutup dialog loading

                    if (authProvider.user != null) {
                      _showSuccessMessage(context, "Login Google berhasil!"); // Tampilkan pesan berhasil
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                      );
                    } else if (authProvider.errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            authProvider.errorMessage!.toString(),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }else{
                      print("Eror bang");
                    }
                  }),
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Belum memiliki akun?",
                  style: TextStyle(
                      fontFamily: "Lato",
                      color: const Color.fromRGBO(0, 73, 124, 1),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Register()));
                  },
                  child: Text(
                    "Daftar",
                    style: TextStyle(
                        fontFamily: "Lato",
                        color: const Color.fromRGBO(2, 138, 234, 1),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            TextButton(
                onPressed: () async {
                  if (_emailController.text.isNotEmpty) {
                    await authProvider.resetPassword(_emailController.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Password reset link sent!')),
                    );
                  }
                },
                child: Text(
                  "Lupa password?",
                  style: TextStyle(
                      fontFamily: "Lato",
                      color: const Color.fromRGBO(2, 138, 234, 1),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                )),
          ],
        ),
      ),
    );
  }
}
