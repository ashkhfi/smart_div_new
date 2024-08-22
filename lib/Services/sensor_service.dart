import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_div_new/Models/sensor_model.dart';

class SensorService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Mengambil data dari dokumen dengan ID tertentu secara real-time
  Stream<sensorModel?> streamData() {
    try {
      // Mengambil data secara real-time dari dokumen dengan ID tertentu
      return _db
          .collection('sensors')
          .doc('device1')
          .snapshots()
          .map((snapshot) {
        if (snapshot.exists) {
          return sensorModel.fromJson(snapshot.data() as Map<String, dynamic>);
        } else {
          return null; // Dokumen tidak ditemukan
        }
      });
    } catch (e) {
      print('Error getting document stream: $e');
      return Stream.value(
          null); // Mengembalikan stream kosong jika terjadi error
    }
  }

  Future<void> updateRelayStatus(
      String commandAndroid) async {
    try {
      await _db.collection('sensors').doc('device1').update({
        'commandAndroid': commandAndroid,
      });
    } catch (e) {
      print('Failed to update relay status: $e');
    } finally {
      print(
          'command status updated: command android - $commandAndroid');
    }
  }
}
