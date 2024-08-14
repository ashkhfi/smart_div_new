import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../Partials/Button/BackButton.dart';
import '../Provider/user_provider.dart';
import 'Login.dart';
import 'Profile.dart';

class Pengaturan extends StatefulWidget {
  const Pengaturan({super.key});

  @override
  _PengaturanState createState() => _PengaturanState();
}

class _PengaturanState extends State<Pengaturan> {
  /// untuk list widget pengaturan
  ///
  List<dynamic> data_item = [
    {'name': 'Nomor telepon', 'icon': Icons.phone_android, 'go': const Login()},
    {
      'name': 'Profil',
      'icon': LucideIcons.user,
      'go': const Profile(),
    },
    {
      'name': 'Notifikasi',
      'icon': LucideIcons.bell,
      'go': const Login(),
    },
    {
      'name': 'Keluar',
      'icon': LucideIcons.logOut,
      'go': const Login(),
    },
  ];
  void loadUser() {
    final _userProvider = Provider.of<UserProvider>(context, listen: false);
    String uid = _userProvider.userData!.uid;
    _userProvider.loadUserData(uid);
  }

  @override
  void initState() {
    loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
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
                    "Pengaturan",
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
          Padding(
            padding: EdgeInsets.only(left: 20.w, top: 30.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30.dm,
                  backgroundImage:
                      const AssetImage("assets/images/man_21.webp"),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userProvider.userData?.name ?? "__",
                      style: TextStyle(
                          color: const Color.fromRGBO(0, 73, 124, 1),
                          fontFamily: "Lato",
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp),
                    ),
                    Text(
                      userProvider.userData?.email ?? "__",
                      style: TextStyle(
                          color: const Color.fromRGBO(0, 73, 124, 1),
                          fontFamily: "Lato",
                          fontWeight: FontWeight.normal,
                          fontSize: 16.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50.h,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                itemCount: data_item.length,
                itemBuilder: ((context, index) {
                  return InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => data_item[index]['go'])),
                    child: ListTile(
                      leading: Icon(data_item[index]['icon']),
                      title: Text(
                        data_item[index]['name'],
                        style: TextStyle(
                            color: const Color.fromRGBO(0, 73, 124, 1),
                            fontFamily: "Lato",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: const Color.fromRGBO(0, 73, 124, 1),
                        size: 20.dm,
                      ),
                    ),
                  );
                })),
          )
        ],
      ),
    );
  }
}
