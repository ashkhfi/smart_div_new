import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Models/weekly_usage_model.dart';



class LineWidget{
LineWidget({
  this.arr_data
});

List<WeeklyUsage>? arr_data;

List<FlSpot> getSpotsPln(){
  return arr_data!.asMap().entries.map((e){
     int index = e.key;
     WeeklyUsage item = e.value;
     return FlSpot(index.toDouble(), item.plnUsage); 
  }).toList();
}

List<FlSpot> getSpotsRe(){
  return arr_data!.asMap().entries.map((e){
     int index = e.key;
     WeeklyUsage item = e.value;
     return FlSpot(index.toDouble(), item.reUsage); 
  }).toList();
}

Widget LineChartWidget(BuildContext context){
  return LineChart(
    LineChartData(
      gridData: const FlGridData(show: true),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              int index = value.toInt();
              if(index >= 0 && index < arr_data!.length){
                return Transform.rotate(
                  angle: -1.5, 
                  child:Padding(
                    padding: EdgeInsets.only(right:15.h),
                    child: Text(arr_data![index].date.toString(), style: TextStyle(
                    color: Colors.black, 
                    fontSize: 8.sp,
                    fontFamily: "Lato"
                                  ),),
                  )
                ); 
              }
              return const Text('');
            },
          )
        )
      ),
      borderData: FlBorderData(show: true),
      lineBarsData: [
        LineChartBarData(
          spots: getSpotsPln(),
          isCurved: true, 
          barWidth: 3, 
          color: Colors.blue, 
        ),
        LineChartBarData(
          spots: getSpotsRe(),
          isCurved: true, 
          barWidth: 3, 
          color: Colors.green, 
        ),
      ]
    )
  ); 
}
}
