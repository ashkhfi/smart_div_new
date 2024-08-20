// lib/models/weekly_usage_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class WeeklyUsage {
  final double reUsage;
  final double plnUsage;
  final DateTime date;

  WeeklyUsage({
    required this.reUsage,
    required this.plnUsage,
    required this.date,
  });

  factory WeeklyUsage.fromJson(Map<String, dynamic> json) {
    return WeeklyUsage(
      reUsage: (json['re_usage'] as num).toDouble(),
      plnUsage: (json['pln_usage'] as num).toDouble(),
      date: (json['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      're_usage': reUsage,
      'pln_usage': plnUsage,
      'date': Timestamp.fromDate(date),
    };
  }

   FlSpot toFlSpot() {
    return FlSpot(
      date.difference(DateTime(date.year, date.month, 1)).inDays.toDouble(), // X-axis as days from start of month
      reUsage, // Y-axis as reUsage value
    );
  }
}
