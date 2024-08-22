import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:smart_div_new/Models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> addUser(String userId, Map<String, dynamic> userData) async {
    try {
      await _firestore.collection('users').doc(userId).set(userData);
    } catch (e) {
      print('Error adding user data: $e');
    }
  }

  Future<Map<String, dynamic>?> getUser(String userId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(userId).get();
      return doc.data() as Map<String, dynamic>?;
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(userId).update(data);
    } catch (e) {
      print('Error updating user: $e');
      rethrow;
    }
  }

  Future<void> notif(String userId, bool notif) async {
    try {
      await _firestore.collection('users').doc(userId).update({'notif': notif});
    } catch (e) {
      print('Error updating user: $e');
      rethrow;
    }
  }

 Stream<UserModel?> streamData(String uid) {
    try {
      // Mengambil data secara real-time dari dokumen dengan ID tertentu
      return _firestore
          .collection('users')
          .doc(uid)
          .snapshots()
          .map((snapshot) {
        if (snapshot.exists) {
          return UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
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

  Future<bool> isEmailAvailable(String email) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking email availability: $e');
      return false;
    }
  }

  // Fungsi untuk mengunggah gambar ke Firebase Storage
  Future<String?> uploadImage(File image, String userId) async {
    try {
      // Path penyimpanan di Firebase Storage
      final ref = _storage.ref().child('users').child('$userId.jpg');

      // Unggah gambar ke Firebase Storage
      final uploadTask = await ref.putFile(image);

      // Dapatkan URL unduhan gambar yang diunggah
      final imageUrl = await uploadTask.ref.getDownloadURL();

      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}
