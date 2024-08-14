import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_div_new/Models/sensor_model.dart';

class SensorService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  
  Future<sensorModel?> getData() async {
    try {
      
      final QuerySnapshot querySnapshot =
          await _db.collection('sensors').get();

      if (querySnapshot.docs.isNotEmpty) {
      
        final doc = querySnapshot.docs.first;
      
        return sensorModel.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        return null; // Koleksi kosong
      }
    } catch (e) {
      print('Error getting first document: $e');
      return null; // Error atau dokumen tidak ditemukan
    }
  }
}
