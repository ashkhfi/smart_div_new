// lib/services/firestore_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/weekly_usage_model.dart';

class WeeklyUsageService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // Mendapatkan data dari koleksi weekly_usage dengan paginasi
  Future<Map<String, dynamic>> getAllDataPagination({
    required int page,
    required int limit,
    DocumentSnapshot? startAfter,
  }) async {
    try {
      // Hitung total data untuk menghitung total halaman
      final totalCountSnapshot = await _db.collection('weekly_usage').get();
      final totalDocuments = totalCountSnapshot.size;
      final totalPages = (totalDocuments / limit).ceil();

      Query query = _db.collection('weekly_usage')
                        .orderBy('date', descending: true)
                        .limit(limit);

      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }

      final snapshot = await query.get();
      final data = snapshot.docs.map((doc) {
        final json = doc.data() as Map<String, dynamic>;
        return WeeklyUsage.fromJson(json);
      }).toList();

      return {
        'data': data,
        'lastDocument': snapshot.docs.isNotEmpty ? snapshot.docs.last : null,
        'hasMore': snapshot.docs.length == limit,
        'totalPages': totalPages,
      };
    } catch (e) {
      print('Error getting weekly usage data: $e');
      return {
        'data': [],
        'lastDocument': null,
        'hasMore': false,
        'totalPages': 0,
      };
    }
  }

  Future<List<WeeklyUsage>> getAllData({required int page}) async {
    try {
      final snapshot = await _db.collection('weekly_usage').get();

      if (snapshot.docs.isEmpty) {
        return [];
      }
      return snapshot.docs.map((doc) {
        final data = doc.data();
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
      final sevenDaysAgo = now.subtract(const Duration(days: 7));

      final querySnapshot = await _db
          .collection('weekly_usage')
          .where('date', isGreaterThanOrEqualTo: sevenDaysAgo)
          .orderBy('date', descending: true)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return [];
      }

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
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

  Future<double> getTotalREusageLast7Days() async {
    final usages = await getWeeklyData();
    final totalREUsage =
        usages.fold<double>(0.0, (sum, usage) => sum + usage.reUsage);
    return totalREUsage;
  }
}
