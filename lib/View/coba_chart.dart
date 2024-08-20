import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../Models/weekly_usage_model.dart';

class LineChartSample extends StatelessWidget {
  final List<WeeklyUsage> weeklyUsageData;

  const LineChartSample({super.key, required this.weeklyUsageData});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LegendItem(color: Colors.blue, text: 'RE Usage'),
              SizedBox(width: 10),
              LegendItem(color: Colors.red, text: 'PLN Usage'),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(mainData()),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    List<Color> gradientColors = [
      Colors.blue,
      const Color(0xff2575fc),
    ];

    return LineChartData(
      backgroundColor: Colors.white, // Background chart warna terang
      lineTouchData: LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (List<LineBarSpot> touchedSpots) {
            final touchedSpot = touchedSpots.firstWhere(
              (spot) => spot.bar.gradient?.colors.first == Colors.blue,
              orElse: () => touchedSpots.first,
            );
            return [
              LineTooltipItem(
                'RE : ${touchedSpot.y}',
                const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              if (touchedSpots.length > 1)
                LineTooltipItem(
                  'PLN : ${touchedSpots.last.y}\n\n ${DateFormat('d/M/y', 'id_ID').format(weeklyUsageData[touchedSpots.last.x.toInt()].date)}',
                  const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
            ];
          },
          getTooltipColor: (touchedSpot) => Colors.blueGrey.withOpacity(0.8),
        ),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 20,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xffe0e0e0),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xffe0e0e0),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: weeklyUsageData.length.toDouble() - 1,
            getTitlesWidget: (double value, TitleMeta meta) {
              int index = value.toInt();
              if (index == 0) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    DateFormat('dd/MM')
                        .format(weeklyUsageData.first.date),
                    style: const TextStyle(
                      fontSize: 10,
                      fontStyle: FontStyle.italic, // Tanggal miring
                      color: Colors.black, // Warna teks
                    ),
                  ),
                );
              } else if (index == weeklyUsageData.length - 1) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    DateFormat('dd/MM')
                        .format(weeklyUsageData.last.date),
                    style: const TextStyle(
                      fontSize: 10,
                      fontStyle: FontStyle.italic, // Tanggal miring
                      color: Colors.black, // Warna teks
                    ),
                  ),
                );
              }
              return SideTitleWidget(
                axisSide: meta.axisSide,
                child: const Text(''),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 42,
            interval: 20,
            getTitlesWidget: (double value, TitleMeta meta) {
              return SideTitleWidget(
                axisSide: meta.axisSide,
                child: Text(
                  value.toInt().toString(),
                  style: const TextStyle(
                      fontSize: 10, color: Colors.black), // Warna teks
                ),
              );
            },
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xffe0e0e0)),
      ),
      minX: 0,
      maxX: weeklyUsageData.length.toDouble() - 1,
      minY: 0,
      maxY: 20,
      lineBarsData: [
        LineChartBarData(
          spots: weeklyUsageData.asMap().entries.map((entry) {
            return FlSpot(entry.key.toDouble(), entry.value.reUsage);
          }).toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
        ),
        LineChartBarData(
          spots: weeklyUsageData.asMap().entries.map((entry) {
            return FlSpot(entry.key.toDouble(), entry.value.plnUsage);
          }).toList(),
          isCurved: true,
          gradient: const LinearGradient(
            colors: [Colors.red, Colors.redAccent],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
        ),
      ],
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 10,
          height: 10,
          color: color,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}