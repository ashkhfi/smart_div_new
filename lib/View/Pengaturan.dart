import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:smart_div_new/Provider/auth_provider.dart';
import 'package:smart_div_new/Provider/fcm_provider.dart';

import '../Partials/Button/BackButton.dart';
import '../Provider/user_provider.dart';
import 'Login.dart';
import 'Notifikasi.dart';
import 'Profile.dart';

class Pengaturan extends StatefulWidget {
  const Pengaturan({super.key});

  @override
  _PengaturanState createState() => _PengaturanState();
}

class _PengaturanState extends State<Pengaturan> {
  /// untuk list widget pengaturan
  ///

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    // Pastikan userData sudah tersedia sebelum melanjutkan
    if (userProvider.userData == null) {
      return Scaffold(
        body: Center(
            child:
                CircularProgressIndicator()), // Menampilkan loader saat data belum siap
      );
    }

    List<dynamic> data_item = [
      {
        'name': 'Profil',
        'icon': LucideIcons.user,
        'go': const Profile(),
      },
      {
        'name': 'Notifikasi',
        'icon': LucideIcons.bell,
        'go': NotificationSettings(
          userId: userProvider.userData!.uid,
        ),
      },
    ];
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
                  radius: 20.dm,
                  backgroundColor: Colors.white,
                  backgroundImage: CachedNetworkImageProvider(
                    userProvider.userData?.image ?? "",
                    cacheKey: userProvider.userData?.image ?? "",
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userProvider.userData?.name ?? "xxxxx",
                      style: TextStyle(
                          color: const Color.fromRGBO(0, 73, 124, 1),
                          fontFamily: "Lato",
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp),
                    ),
                    Text(
                      userProvider.userData?.email ?? "xxx",
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
          Expanded(
            child: ListView(
              children: [
                ...data_item.map((item) {
                  return InkWell(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => item['go'])),
                    child: ListTile(
                      leading: Icon(item['icon']),
                      title: Text(
                        item['name'],
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
                }),
                ListTile(
                  onTap: () async {
                    final notifProvider = Provider.of<NotificationProvider>(
                        context,
                        listen: false);
                    final authProvider =
                        Provider.of<AuthProvider>(context, listen: false);

                    bool shouldLogout = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Konfirmasi"),
                          content:
                              const Text("Apakah Anda yakin ingin keluar?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(false); // Tidak jadi keluar
                              },
                              child: const Text("Tidak"),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Login(),
                                  ),
                                );

                                await Provider.of<NotificationProvider>(context,
                                        listen: false)
                                    .logout("power_status");
                                await authProvider.signOut();
                              },
                              child: const Text("Ya"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  leading: const Icon(LucideIcons.logOut),
                  title: Text(
                    "Keluar",
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
