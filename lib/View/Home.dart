import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:smart_div_new/Provider/sensor_provider.dart';
import 'package:smart_div_new/Provider/user_provider.dart';

import '../Partials/Card/CardMode.dart';
import '../Partials/Card/DashboardCard.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SensorProvider>(context, listen: false).fetchData();
    });
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
      body: Stack(children: [
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
                    backgroundImage: userProvider.userData?.image != null
                        ? NetworkImage(userProvider.userData!.image!)
                        : null,
                    child: userProvider.userData?.image == null
                        ? Icon(Icons.person, size: 50.dm, color: Colors.grey)
                        : null,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userProvider.userData?.name ?? "Kosong",
                        style: TextStyle(
                            color: const Color.fromRGBO(0, 73, 124, 1),
                            fontFamily: "Lato",
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp),
                      ),
                      Text(
                        userProvider.userData?.jabatan ?? "________",
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
                                builder: (context) => const Pengaturan()));
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
            /** 
             * 
             *card untuk menampilkan mode di home , 
             note: onRefresh if refreshed icon tapped
             */
            CardMode(context, mode: sensorProvider.sensor?.modeAktif ?? "__",
                onRefresh: () async {
              await sensorProvider.fetchData();
            }),
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
                            color: Colors.amber,
                            onTap: () {}),
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
                            color: Colors.blue,
                            onTap: () {}),
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
                        children: [
                          SingleChildScrollView(
                            controller: scrollController,
                            /**
                             * edit menampilkan data pada file ListEnergy.dart
                             */
                            child: const ListEnergy(),
                          ),
                          /**
                             * edit menampilkan data pada file ListPLN.dart
                             */
                          SingleChildScrollView(
                            controller: scrollController,
                            child: const ListPLN(),
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
