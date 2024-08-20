// /// Package imports
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// /// Chart import
// import 'package:syncfusion_flutter_charts/charts.dart';

// import '../../Models/weekly_usage_model.dart';

// class LineChartSample extends StatelessWidget {
//   final List<WeeklyUsage> weeklyUsageData;

//   LineChartSample({super.key, required this.weeklyUsageData});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Line Chart Example')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SfCartesianChart(
//           primaryXAxis: DateTimeAxis(
//             dateFormat: DateFormat('dd/MM'),
//             edgeLabelPlacement: EdgeLabelPlacement.shift,
//             intervalType: DateTimeIntervalType.days,
//             majorGridLines: MajorGridLines(width: 0),
//           ),
//           primaryYAxis: NumericAxis(
//             minimum: 0,
//             maximum: 100,
//             interval: 10,
//             title: AxisTitle(text: 'Usage'),
//             labelFormat: '{value}%',
//           ),
//           series: <CartesianSeries>[
//             LineSeries<WeeklyUsage, DateTime>(
//               name: 'PLN Usage',
//               dataSource: weeklyUsageData,
//               xValueMapper: (WeeklyUsage usage, _) => usage.date,
//               yValueMapper: (WeeklyUsage usage, _) => usage.plnUsage,
//               color: Colors.cyan,
//               width: 3,
//               markerSettings: MarkerSettings(isVisible: true),
//             ),
//             LineSeries<WeeklyUsage, DateTime>(
//               name: 'RE Usage',
//               dataSource: weeklyUsageData,
//               xValueMapper: (WeeklyUsage usage, _) => usage.date,
//               yValueMapper: (WeeklyUsage usage, _) => usage.reUsage,
//               color: Colors.orange,
//               width: 3,
//               markerSettings: MarkerSettings(isVisible: true),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }