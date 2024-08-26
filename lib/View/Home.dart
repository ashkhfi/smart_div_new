import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:smart_div_new/Provider/auth_provider.dart';
import 'package:smart_div_new/Provider/sensor_provider.dart';
import 'package:smart_div_new/Provider/user_provider.dart';
import 'package:smart_div_new/View/Cuaca.dart';
import 'package:smart_div_new/View/PenggunaanDaya.dart';

import '../Partials/Card/CardMode.dart';
import '../Partials/Card/DashboardCard.dart';
import 'Kontrol_Daya.dart';
import 'ListEnergy.dart';
import 'ListPLN.dart';
import 'Pengaturan.dart';
import 'PengeluaranBiaya.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final sensorProvider = Provider.of<SensorProvider>(context);
    return Scaffold(
      body: userProvider.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          radius: 20.dm,
                          backgroundColor: Colors.white,
                          backgroundImage: CachedNetworkImageProvider(
                            userProvider.userData?.image ?? "",
                            cacheKey: userProvider.userData?.image ?? "",
                          ),
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
                              userProvider.userData?.jabatan ?? "",
                              style: TextStyle(
                                  color: const Color.fromRGBO(0, 73, 124, 1),
                                  fontFamily: "Lato",
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.sp),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Pengaturan()));
                            },
                            icon: const Icon(
                              LucideIcons.settings,
                              color: Color.fromRGBO(0, 73, 124, 1),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CardMode(
                    mode: sensorProvider.sensor?.mode ?? "__",
                    onRefresh: () async {
                      sensorProvider.getDataSensor();
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Dashboard",
                        style: TextStyle(
                            color: const Color.fromRGBO(0, 73, 124, 1),
                            fontFamily: "Lato",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 160.dm,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: EdgeInsets.all(10.dm),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5.dm),
                              child: DashboardCard(context,
                                  label: "Penggunaan Daya Listrik",
                                  icon: Icons.electric_bolt,
                                  color: Colors.amber, onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Penggunaandaya()));
                              }),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.dm),
                              child: DashboardCard(context,
                                  label: "Pengeluaran Keuangan",
                                  icon: LucideIcons.badgeDollarSign,
                                  color: Colors.green, onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PengeluaranBiaya()));
                              }),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.dm),
                              child: DashboardCard(context,
                                  label: "Perkiraan Cuaca",
                                  icon: LucideIcons.cloudSunRain,
                                  color: Colors.blue, onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Cuaca()),
                                );
                              }),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.dm),
                              child: DashboardCard(context,
                                  label: "Kontrol Daya Energi",
                                  icon: Icons.cable,
                                  color: Colors.redAccent, onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => KontrolDaya()),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Monitoring Sumber Energi",
                        style: TextStyle(
                            color: const Color.fromRGBO(0, 73, 124, 1),
                            fontFamily: "Lato",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              // SizedBox(
              //   height: 10,
              // ),
              DraggableScrollableSheet(
                  minChildSize: 0.4,
                  initialChildSize: 0.4,
                  maxChildSize: 0.9,
                  builder: (((context, scrollController) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 0.5,
                              offset: Offset(0, 0.5))
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                            child: TabBar(
                              controller: _tabController,
                              tabs: const [
                                Tab(text: "Renewable Energy"),
                                Tab(text: "PLN"),
                              ],
                            ),
                          ),
                          Flexible(
                            child: TabBarView(
                              controller: _tabController,
                              children: const [
                                SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  // controller: scrollController,
                                  /**
                             * edit menampilkan data pada file ListEnergy.dart
                             */
                                  child: ListEnergy(),
                                ),
                                /**
                             * edit menampilkan data pada file ListPLN.dart
                             */
                                SingleChildScrollView(
                                  // controller: scrollController,
                                  physics: BouncingScrollPhysics(),
                                  child: ListPLN(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  })))
            ]),
    );
  }
}
