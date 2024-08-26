import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_div_new/Models/sensor_model.dart';

class SensorService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<sensorModel?> streamData() {
    try {
      return _db.collection('sensors').doc('device1').snapshots().map((snapshot) {
        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

          // Periksa dan atasi NaN jika nilainya adalah string "NaN"
          data.forEach((key, value) {
            if (value is String && value == ' NAN') {
              data[key] = '0.00'; 
            }
          });

          return sensorModel.fromJson(data);
        } else {
          return null; // Dokumen tidak ditemukan
        }
      });
    } catch (e) {
      print('Error getting document stream: $e');
      return Stream.value(null); // Mengembalikan stream kosong jika terjadi error
    }
  }

  Future<void> updateRelayStatus(String commandAndroid) async {
    try {
      await _db.collection('sensors').doc('device1').update({
        'commandAndroid': commandAndroid,
      });
    } catch (e) {
      print('Failed to update relay status: $e');
    } finally {
      print('command status updated: command android - $commandAndroid');
    }
  }
}
