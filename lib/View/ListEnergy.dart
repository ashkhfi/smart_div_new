import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../Provider/sensor_provider.dart';

class ListEnergy extends StatefulWidget {
  const ListEnergy({super.key});

  @override
  _ListEnergyState createState() => _ListEnergyState();
}

class _ListEnergyState extends State<ListEnergy> {
  @override
  Widget build(BuildContext context) {
    final sensorProvider = Provider.of<SensorProvider>(context);
    return Column(
      children: [
        //pltb
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 120.h,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: const Color.fromRGBO(2, 138, 234, 1), width: 2.dm),
                borderRadius: BorderRadius.circular(10.dm),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(2, 138, 234, 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.dm),
                            topRight: Radius.circular(5.dm))),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Text(
                            "PLTB",
                            style: TextStyle(
                                fontFamily: "Lato",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: 22.h,
                              decoration: BoxDecoration(
                                  color: sensorProvider.sensor?.irsPltb ==
                                              "0.00" &&
                                          sensorProvider.sensor?.vrsPltb ==
                                              "0.00"
                                      // 231, 255, 245, 1
                                      ? const Color.fromRGBO(255, 231, 231, 1)
                                      : const Color.fromRGBO(231, 255, 245, 1),
                                  borderRadius: BorderRadius.circular(10.dm)),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 2.dm,
                                    bottom: 2.dm,
                                    left: 5.dm,
                                    right: 5.dm),
                                child: Center(
                                  child: Text(
                                    sensorProvider.sensor?.irsPltb == "0.00" &&
                                            sensorProvider.sensor?.vrsPltb ==
                                                "0.00"
                                        ? "Inactive"
                                        : "Active",
                                    style: TextStyle(
                                        fontFamily: "Lato",
                                        fontSize: 14.sp,
                                        color:
                                            (sensorProvider.sensor?.irsPltb ==
                                                        "0.00" &&
                                                    sensorProvider
                                                            .sensor?.vrsPltb ==
                                                        "0.00")

                                                //  255, 67, 67, 1
                                                ? const Color.fromRGBO(
                                                    255, 67, 67, 1)
                                                : const Color.fromRGBO(
                                                    19, 169, 124, 1)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Vrs = ${sensorProvider.sensor?.vrsPltb ?? 0.00}v",
                              style: TextStyle(
                                fontFamily: "Lato",
                                fontSize: 16.sp,
                                color: const Color.fromRGBO(2, 138, 234, 1),
                              ),
                            ),
                            Text(
                              "Irs = ${sensorProvider.sensor?.irsPltb ?? 0.00}A",
                              style: TextStyle(
                                fontFamily: "Lato",
                                fontSize: 16.sp,
                                color: const Color.fromRGBO(2, 138, 234, 1),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Vst = ${sensorProvider.sensor?.vstPltb ?? 0.00}v",
                              style: TextStyle(
                                fontFamily: "Lato",
                                fontSize: 16.sp,
                                color: const Color.fromRGBO(2, 138, 234, 1),
                              ),
                            ),
                            Text(
                              "Ist = ${sensorProvider.sensor?.istPltb ?? 0.00}A",
                              style: TextStyle(
                                fontFamily: "Lato",
                                fontSize: 16.sp,
                                color: const Color.fromRGBO(2, 138, 234, 1),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Vtr = ${sensorProvider.sensor?.vtrPltb ?? 0.00}v",
                              style: TextStyle(
                                fontFamily: "Lato",
                                fontSize: 16.sp,
                                color: const Color.fromRGBO(2, 138, 234, 1),
                              ),
                            ),
                            Text(
                              "Itr = ${sensorProvider.sensor?.itrPltb ?? 0.00}A",
                              style: TextStyle(
                                fontFamily: "Lato",
                                fontSize: 16.sp,
                                color: const Color.fromRGBO(2, 138, 234, 1),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // plts
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 80.h,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: const Color.fromRGBO(2, 138, 234, 1), width: 2.dm),
                borderRadius: BorderRadius.circular(10.dm),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(2, 138, 234, 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.dm),
                            topRight: Radius.circular(5.dm))),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Text(
                            "PLTS",
                            style: TextStyle(
                                fontFamily: "Lato",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: 22.h,
                              decoration: BoxDecoration(
                                  color: sensorProvider.sensor?.iPlts ==
                                              "0.00" &&
                                          sensorProvider.sensor?.vPlts == "0.00"
                                      // 231, 255, 245, 1
                                      ? const Color.fromRGBO(255, 231, 231, 1)
                                      : const Color.fromRGBO(231, 255, 245, 1),
                                  borderRadius: BorderRadius.circular(10.dm)),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 2.dm,
                                    bottom: 2.dm,
                                    left: 5.dm,
                                    right: 5.dm),
                                child: Center(
                                  child: Text(
                                    sensorProvider.sensor?.iPlts == "0.00" &&
                                            sensorProvider.sensor?.vPlts ==
                                                "0.00"
                                        ? "Inactive"
                                        : "Active",
                                    style: TextStyle(
                                        fontFamily: "Lato",
                                        fontSize: 14.sp,
                                        color: (sensorProvider.sensor?.iPlts ==
                                                    "0.00" &&
                                                sensorProvider.sensor?.vPlts ==
                                                    "0.00")

                                            //  255, 67, 67, 1
                                            ? const Color.fromRGBO(
                                                255, 67, 67, 1)
                                            : const Color.fromRGBO(
                                                19, 169, 124, 1)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  /**
             * 
             * note: edit bagian ini sesuaikan dengan data dari firebase.
             */
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceEvenly, // Untuk meratakan isi Row secara horizontal
                          children: [
                            Text(
                              "V = ${sensorProvider.sensor?.vPlts ?? 0.00}v",
                              style: TextStyle(
                                fontFamily: "Lato",
                                fontSize: 16.sp,
                                color: const Color.fromRGBO(2, 138, 234, 1),
                              ),
                            ),
                            Text(
                              "I = ${sensorProvider.sensor?.iPlts ?? 0.00}A",
                              style: TextStyle(
                                fontFamily: "Lato",
                                fontSize: 16.sp,
                                color: const Color.fromRGBO(2, 138, 234, 1),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        //inverter
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 80.h,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: const Color.fromRGBO(2, 138, 234, 1), width: 2.dm),
                borderRadius: BorderRadius.circular(10.dm),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(2, 138, 234, 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.dm),
                            topRight: Radius.circular(5.dm))),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Text(
                            "Inverter",
                            style: TextStyle(
                                fontFamily: "Lato",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: 22.h,
                              decoration: BoxDecoration(
                                  color: sensorProvider.sensor?.iInverter ==
                                              "0.00" &&
                                          sensorProvider.sensor?.vInverter ==
                                              "0.00"
                                      // 231, 255, 245, 1
                                      ? const Color.fromRGBO(255, 231, 231, 1)
                                      : const Color.fromRGBO(231, 255, 245, 1),
                                  borderRadius: BorderRadius.circular(10.dm)),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 2.dm,
                                    bottom: 2.dm,
                                    left: 5.dm,
                                    right: 5.dm),
                                child: Center(
                                  child: Text(
                                    sensorProvider.sensor?.iInverter == "0.00" &&
                                            sensorProvider.sensor?.vInverter ==
                                                "0.00"
                                        ? "Inactive"
                                        : "Active",
                                    style: TextStyle(
                                        fontFamily: "Lato",
                                        fontSize: 14.sp,
                                        color:
                                            (sensorProvider.sensor?.iInverter ==
                                                        "0.00" &&
                                                    sensorProvider.sensor
                                                            ?.vInverter ==
                                                        "0.00")

                                                //  255, 67, 67, 1
                                                ? const Color.fromRGBO(
                                                    255, 67, 67, 1)
                                                : const Color.fromRGBO(
                                                    19, 169, 124, 1)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  /**
             * 
             * note: edit bagian ini sesuaikan dengan data dari firebase.
             */
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceEvenly, // Untuk meratakan isi Row secara horizontal
                          children: [
                            Text(
                              "V = ${sensorProvider.sensor?.vInverter ?? 0.00}v",
                              style: TextStyle(
                                fontFamily: "Lato",
                                fontSize: 16.sp,
                                color: const Color.fromRGBO(2, 138, 234, 1),
                              ),
                            ),
                            Text(
                              "I = ${sensorProvider.sensor?.iInverter ?? 0.00}A",
                              style: TextStyle(
                                fontFamily: "Lato",
                                fontSize: 16.sp,
                                color: const Color.fromRGBO(2, 138, 234, 1),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        //baterai
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 110.h,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: const Color.fromRGBO(2, 138, 234, 1), width: 2.dm),
                borderRadius: BorderRadius.circular(10.dm),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(2, 138, 234, 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.dm),
                            topRight: Radius.circular(5.dm))),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Text(
                            "Baterai",
                            style: TextStyle(
                                fontFamily: "Lato",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: 22.h,
                              decoration: BoxDecoration(
                                  color: sensorProvider.sensor?.iBaterai ==
                                              "0.00" &&
                                          sensorProvider.sensor?.vBaterai ==
                                              "0.00"
                                      // 231, 255, 245, 1
                                      ? const Color.fromRGBO(255, 231, 231, 1)
                                      : const Color.fromRGBO(231, 255, 245, 1),
                                  borderRadius: BorderRadius.circular(10.dm)),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 2.dm,
                                    bottom: 2.dm,
                                    left: 5.dm,
                                    right: 5.dm),
                                child: Center(
                                  child: Text(
                                    sensorProvider.sensor?.iBaterai == "0.00" &&
                                            sensorProvider.sensor?.vBaterai ==
                                                "0.00"
                                        ? "Inactive"
                                        : "Active",
                                    style: TextStyle(
                                        fontFamily: "Lato",
                                        fontSize: 14.sp,
                                        color:
                                            (sensorProvider.sensor?.iBaterai ==
                                                        "0.00" &&
                                                    sensorProvider
                                                            .sensor?.vBaterai ==
                                                        "0.00")

                                                //  255, 67, 67, 1
                                                ? const Color.fromRGBO(
                                                    255, 67, 67, 1)
                                                : const Color.fromRGBO(
                                                    19, 169, 124, 1)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  /**
             * 
             * note: edit bagian ini sesuaikan dengan data dari firebase.
             */
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Column(
                      children: [
                        Text(
                          "V = ${sensorProvider.sensor?.vBaterai ?? 0.00}v",
                          style: TextStyle(
                            fontFamily: "Lato",
                            fontSize: 16.sp,
                            color: const Color.fromRGBO(2, 138, 234, 1),
                          ),
                        ),
                        Text(
                          "I = ${sensorProvider.sensor?.iBaterai ?? 0.00}A",
                          style: TextStyle(
                            fontFamily: "Lato",
                            fontSize: 16.sp,
                            color: const Color.fromRGBO(2, 138, 234, 1),
                          ),
                        ),
                        Text(
                          "Soc = ${sensorProvider.sensor?.socBaterai ?? 0.00}%",
                          style: TextStyle(
                            fontFamily: "Lato",
                            fontSize: 16.sp,
                            color: const Color.fromRGBO(2, 138, 234, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
