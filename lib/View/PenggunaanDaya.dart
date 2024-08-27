import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_div_new/Provider/sensor_provider.dart';
import 'package:smart_div_new/Provider/weekly_usage_provider.dart';
import '../Partials/Button/BackButton.dart';
import '../Partials/Card/BaseCard.dart';
import 'coba_chart.dart';

class Penggunaandaya extends StatefulWidget {
  const Penggunaandaya({super.key});

  @override
  State<Penggunaandaya> createState() => _PenggunaandayaState();
}

class _PenggunaandayaState extends State<Penggunaandaya> {
  bool showAvg = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<WeeklyUsageProvider>(context, listen: false);
      provider.fetchFirstPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final usageProvider = Provider.of<WeeklyUsageProvider>(context);
    final sensorProvider = Provider.of<SensorProvider>(context);

    return Scaffold(
      body: usageProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40.h),
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
                              "Penggunaan Daya",
                              style: TextStyle(
                                fontFamily: "Lato",
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromRGBO(0, 73, 124, 1),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      height: MediaQuery.of(context).size.height / 4,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.dm),
                          bottomRight: Radius.circular(10.dm),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 0.4,
                            spreadRadius: 0.3,
                            offset: Offset(0, 1.2),
                          ),
                        ],
                      ),
                      child: LineChartSample(
                        weeklyUsageData: usageProvider.allweeklyUsages,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.all(10.dm),
                      child: Text(
                        "Penggunaan Hari Ini",
                        style: TextStyle(
                          fontFamily: "Lato",
                          fontSize: 16.sp,
                          color: const Color.fromRGBO(0, 73, 124, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Center(
                      child: BaseCard(
                        context,
                        height: MediaQuery.of(context).size.height * 0.18,
                        width: MediaQuery.of(context).size.width * 0.9,
                        widget: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.87,
                            height: MediaQuery.of(context).size.height * 0.18,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.dm)),
                            child: Padding(
                              padding: EdgeInsets.all(20.dm),
                              child: Consumer<SensorProvider>(
                                builder: (context, value, child) {
                                  // Fungsi untuk mengonversi String ke double dengan nilai default
                                  double parseDouble(String? value,
                                      {double defaultValue = 0.00}) {
                                    if (value == null) return defaultValue;
                                    final parsed = double.tryParse(value);
                                    return parsed ?? defaultValue;
                                  }

                                  double reUsage = double.tryParse(
                                          sensorProvider.sensor!.reUsage) ??
                                      0.0;
                                  double plnUsage = double.tryParse(
                                          sensorProvider.sensor!.plnUsage) ??
                                      0.0;

                                  String pencentage =
                                      "${(plnUsage != 0) ? ((reUsage / plnUsage) * 100) : 0}%";
                                  String percentageWithoutSymbol =
                                      pencentage.replaceAll('%', '');
                                  double percentageValue =
                                      double.parse(percentageWithoutSymbol);

                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Penggunaan RE",
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    0, 73, 124, 1),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.sp,
                                                fontFamily: "Lato"),
                                          ),
                                          Text(
                                            "$reUsage Kwh",
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    0, 73, 124, 1),
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16.sp,
                                                fontFamily: "Lato"),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Penggunaan PLN",
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    0, 73, 124, 1),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.sp,
                                                fontFamily: "Lato"),
                                          ),
                                          Text(
                                            "$plnUsage Kwh",
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    0, 73, 124, 1),
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16.sp,
                                                fontFamily: "Lato"),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Presentase",
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    0, 73, 124, 1),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.sp,
                                                fontFamily: "Lato"),
                                          ),
                                          Text(
                                            "${percentageValue.toStringAsFixed(2)} %",
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    0, 73, 124, 1),
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16.sp,
                                                fontFamily: "Lato"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10.dm, right: 10.dm, top: 10.dm),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Riwayat Penggunaan",
                            style: TextStyle(
                              color: const Color.fromRGBO(0, 73, 124, 1),
                              fontFamily: "Lato",
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: usageProvider.hasPreviousPage
                                      ? () {
                                          usageProvider.fetchPreviousPage();
                                        }
                                      : null,
                                  icon: Icon(
                                    Icons.arrow_back_ios_new_outlined,
                                    size: 20,
                                    color: usageProvider.hasPreviousPage
                                        ? const Color.fromRGBO(0, 73, 124, 1)
                                        : Colors.grey,
                                  ),
                                ),
                                Text(
                                  usageProvider.currentPage.toString(),
                                  style: TextStyle(
                                    color: const Color.fromRGBO(0, 73, 124, 1),
                                    fontFamily: "Lato",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                Text(
                                  "/${usageProvider.totalPages.toString()}",
                                  style: TextStyle(
                                    color: const Color.fromRGBO(0, 73, 124, 1),
                                    fontFamily: "Lato",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                IconButton(
                                  onPressed: usageProvider.hasNextPage
                                      ? () {
                                          usageProvider.fetchNextPage();
                                        }
                                      : null, // Nonaktifkan tombol jika tidak ada halaman berikutnya
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: usageProvider.hasNextPage
                                        ? const Color.fromRGBO(0, 73, 124,
                                            1) // Biru jika ada halaman berikutnya
                                        : Colors
                                            .grey, // Abu-abu jika tidak ada halaman berikutnya
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Consumer<WeeklyUsageProvider>(
                        builder: (context, provider, child) {
                          if (provider.isLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          if (provider.errorMessage != null) {
                            print(provider.errorMessage);
                            return Center(
                              child: Text(
                                'Failed to load data: ${provider.errorMessage}',
                                style: const TextStyle(color: Colors.red),
                              ),
                            );
                          }

                          return Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: provider.weeklyUsages.length,
                                  itemBuilder: (context, index) {
                                    final usage = provider.weeklyUsages[index];
                                    final formattedDate = DateFormat('dd/MM/yy')
                                        .format(usage.date);

                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      margin: EdgeInsets.only(
                                          bottom: 10.h, right: 8.w, left: 8.w),
                                      height: 55.h,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: const Color.fromRGBO(
                                                2, 138, 234, 1),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "RE    ",
                                                    style: TextStyle(
                                                        color: const Color
                                                            .fromRGBO(
                                                            0, 73, 124, 1),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16.sp,
                                                        fontFamily: "Lato"),
                                                  ),
                                                  SizedBox(
                                                    width: 15.w,
                                                  ),
                                                  Text(
                                                    "${usage.reUsage.toStringAsFixed(2)} Kwh",
                                                    style: TextStyle(
                                                        color: const Color
                                                            .fromRGBO(
                                                            0, 73, 124, 1),
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 16.sp,
                                                        fontFamily: "Lato"),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "PLN ",
                                                    style: TextStyle(
                                                        color: const Color
                                                            .fromRGBO(
                                                            0, 73, 124, 1),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16.sp,
                                                        fontFamily: "Lato"),
                                                  ),
                                                  SizedBox(
                                                    width: 15.w,
                                                  ),
                                                  Text(
                                                    "${usage.plnUsage.toStringAsFixed(2)} Kwh",
                                                    style: TextStyle(
                                                        color: const Color
                                                            .fromRGBO(
                                                            0, 73, 124, 1),
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 16.sp,
                                                        fontFamily: "Lato"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                formattedDate,
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        0, 73, 124, 1),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.sp,
                                                    fontFamily: "Lato"),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
