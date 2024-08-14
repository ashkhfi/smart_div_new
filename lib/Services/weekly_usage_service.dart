// lib/services/firestore_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/weekly_usage_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Mendapatkan data dari koleksi weekly_usage
  Future<List<WeeklyUsage>> getAllData() async {
    try {
      final snapshot = await _db.collection('weekly_usage').get();

      if (snapshot.docs.isEmpty) {
        return [];
      }

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return WeeklyUsage.fromJson(data);
      }).toList();
    } catch (e) {
      print('Error getting weekly usage data: $e');
      return [];
    }
  }

  Future<List<WeeklyUsage>> getWeeklyData() async {
    try {
      final now = DateTime.now();
      final sevenDaysAgo = now.subtract(Duration(days: 7));

      final querySnapshot = await _db
          .collection('weekly_usage')
          .where('date', isGreaterThanOrEqualTo: sevenDaysAgo)
          .orderBy('date',
              descending: true) 
          .get();

      if (querySnapshot.docs.isEmpty) {
        return [];
      }

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return WeeklyUsage.fromJson(data);
      }).toList();
    } catch (e) {
      print('Error getting weekly usage data: $e');
      return [];
    }
  }

  Future<double> getTotalPLNUsageLast7Days() async {
    final usages = await getWeeklyData();
    final totalPLNUsage =
        usages.fold<double>(0.0, (sum, usage) => sum + usage.plnUsage);
    return totalPLNUsage;
  }
}
