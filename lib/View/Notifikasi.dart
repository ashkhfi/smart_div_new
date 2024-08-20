import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../Partials/Button/BackButton.dart';
import '../Provider/fcm_provider.dart';


class NotificationSettings extends StatelessWidget {
  final String topic = "power_status";

  const NotificationSettings({super.key}); 

  @override
  Widget build(BuildContext context) {
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
                padding: EdgeInsets.only(left: 20.w, right: 80.w),
                child: KembaliButton(context, onTap: () {
                  Navigator.pop(context);
                }),
              ),
              Center(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Notifikasi",
                    style: TextStyle(
                        fontFamily: "Lato",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromRGBO(0, 73, 124, 1)),
                  ),
                ),
              )
            ],
          ),
          Consumer<NotificationProvider>(
            builder: (context, provider, child) {
              return ListTile(
                title: const Text('Background Notifikasi'),
                trailing: Switch(
                  value: provider.isSubscribed,
                  onChanged: (value) async {
                    await provider.toggleSubscription(topic);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
