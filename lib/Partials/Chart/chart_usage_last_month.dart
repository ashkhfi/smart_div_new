// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// import '../../Models/weekly_usage_model.dart';

// class LineChartSample extends StatelessWidget {
//   final List<WeeklyUsage> weeklyUsageData;

//   LineChartSample({required this.weeklyUsageData});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       child: AspectRatio(
//         aspectRatio: 1.70,
//         child: LineChart(mainData()),
//       ),
//     );
//   }

//   List<FlSpot> getPlnSpots() {
//     return weeklyUsageData.map((usage) => FlSpot(
//       usage.date.difference(DateTime(usage.date.year, usage.date.month, 1)).inDays.toDouble(),
//       usage.plnUsage,
//     )).toList();
//   }

//   List<FlSpot> getReSpots() {
//     return weeklyUsageData.map((usage) => FlSpot(
//       usage.date.difference(DateTime(usage.date.year, usage.date.month, 1)).inDays.toDouble(),
//       usage.reUsage,
//     )).toList();
//   }

//   LineChartData mainData() {
//     return LineChartData(
//       gridData: FlGridData(
//         show: true,
//         drawVerticalLine: true,
//         horizontalInterval: 10,
//         verticalInterval: 10,
//         getDrawingHorizontalLine: (value) {
//           return const FlLine(
//             color: Colors.grey,
//             strokeWidth: 1,
//           );
//         },
//         getDrawingVerticalLine: (value) {
//           return const FlLine(
//             color: Colors.grey,
//             strokeWidth: 1,
//           );
//         },
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 40,
//             interval: 1,
//             getTitlesWidget: bottomTitleWidgets,
//           ),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             interval: 10,
//             getTitlesWidget: leftTitleWidgets,
//             reservedSize: 40,
//           ),
//         ),
//         topTitles: const AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         rightTitles: const AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//       ),
//       borderData: FlBorderData(
//         show: true,
//         border: Border.all(color: const Color(0xff37434d)),
//       ),
//       minX: 0,
//       maxX: weeklyUsageData.isNotEmpty
//           ? weeklyUsageData.last.date.difference(weeklyUsageData.first.date).inDays.toDouble()
//           : 0,
//       minY: 0,
//       maxY: 100,
//       lineBarsData: [
//         LineChartBarData(
//           spots: getPlnSpots(),
//           isCurved: true,
//           color: Colors.blue,
//           barWidth: 5,
//           isStrokeCapRound: true,
//           dotData: const FlDotData(
//             show: false,
//           ),
//           belowBarData: BarAreaData(
//             show: true,
//             gradient: LinearGradient(
//               colors: [Colors.cyan.withOpacity(0.3), Colors.blue.withOpacity(0.3)],
//             ),
//           ),
//         ),
//         LineChartBarData(
//           spots: getReSpots(),
//           isCurved: true,
//           color: Colors.blue,
//           barWidth: 5,
//           isStrokeCapRound: true,
//           dotData: const FlDotData(
//             show: false,
//           ),
//           belowBarData: BarAreaData(
//             show: true,
//             gradient: LinearGradient(
//               colors: [Colors.orange.withOpacity(0.3), Colors.red.withOpacity(0.3)],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget bottomTitleWidgets(double value, TitleMeta meta) {
//     final date = DateTime(2024, 1, value.toInt() + 1);
//     final formattedDate = '${date.month}/${date.day}/${date.year}';
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       child: Text(
//         formattedDate,
//         style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
//       ),
//     );
//   }

//   Widget leftTitleWidgets(double value, TitleMeta meta) {
//     return Text(
//       value.toInt().toString(),
//       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
//     );
//   }
// }
