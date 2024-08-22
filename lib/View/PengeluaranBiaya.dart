import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../Partials/Button/BackButton.dart';
import '../Partials/Card/CardBiaya.dart';
import '../Partials/Widget/PercentBar.dart';
import '../Provider/expense_provider.dart';
import '../utils/formater/format_rp.dart';

class PengeluaranBiaya extends StatefulWidget {
  const PengeluaranBiaya({super.key});

  @override
  _PengeluaranBiayaState createState() => _PengeluaranBiayaState();
}

class _PengeluaranBiayaState extends State<PengeluaranBiaya> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ExpenseProvider>(context, listen: false).loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Menggunakan listen: true untuk mendapatkan perubahan data setiap kali provider di-update
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    String percentage = formatCurrency(expenseProvider.percentage ?? 0.0);

    double percentageFix =
        double.parse(percentage.replaceAll(RegExp(r'[^0-9]'), ''));

    print("persen = ${percentageFix}");
    print("normal = ${expenseProvider.normalUsage}");
    print("this week = ${expenseProvider.thisWeekUsage}");
    print("hemat = ${expenseProvider.savings}");
    return Scaffold(
      body: Stack(children: [
        Column(
          children: [
            SizedBox(
              height: 40.h,
            ),
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
                      "Pengeluaran Biaya",
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
            SizedBox(
              height: 30.h,
            ),
            Text(
              "Total Penghematan",
              style: TextStyle(
                  fontFamily: "Lato",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(0, 73, 124, 1)),
            ),
            SizedBox(
              height: 20.h,
            ),
            PercentBar(context,
                percent: percentageFix / 100,
                money:
                    formatCurrency(expenseProvider.savings?.toDouble() ?? 0.0)),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "*Total penghematan pengeluaran daya dibandingkan\ndengan penggunaan PLN",
                  style: TextStyle(
                    color: const Color.fromRGBO(0, 73, 124, 1),
                    fontFamily: "Lato",
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
        DraggableScrollableSheet(
            minChildSize: 0.4,
            maxChildSize: 0.5,
            initialChildSize: 0.4,
            builder: (((context, scrollController) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 0.4,
                          blurRadius: 0.4,
                          offset: Offset(0, 0.4)),
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.dm),
                        topRight: Radius.circular(10.dm))),
                child: ListView(
                  controller: scrollController,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      child: CardBiaya(
                        context,
                        title: "Pengeluaran minggu ini",
                        total: formatCurrency(
                            expenseProvider.thisWeekUsage?.toDouble() ?? 0.0),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      child: CardBiaya(
                        context,
                        title: "Pengeluaran kondisi normal",
                        total: formatCurrency(
                            expenseProvider.normalUsage?.toDouble() ?? 0.0),
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
