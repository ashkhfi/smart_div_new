import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../Partials/Button/BackButton.dart';
import '../Provider/fcm_provider.dart';

class NotificationSettings extends StatelessWidget {
  final String userId;

  const NotificationSettings({super.key, required this.userId});

  final String topic = "power_status";

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NotificationProvider>(context, listen: false)
          .fetchNotificationStatus(userId);
    });
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
          SizedBox(height: 30),
          Consumer<NotificationProvider>(
            builder: (context, provider, child) {
              return SwitchListTile(
                title: Text('Aktifkan Notifikasi'),
                value: provider.notifStatus,
                onChanged: (value) {
                  provider.updateNotificationStatus(userId, value);
                  provider.toggleSubscription("power_status");
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
