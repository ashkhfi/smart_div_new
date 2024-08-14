import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();


  // Method untuk sign in dengan email dan password
  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return UserModel(uid: user!.uid, email: user.email!,name: user.displayName);
    } on FirebaseAuthException catch (e) {
      // Menangani berbagai jenis kesalahan Firebase Auth
      if (e.code == 'user-not-found') {
        print('Email tidak terdaftar.');
      } else if (e.code == 'wrong-password') {
        print('Kata sandi salah.');
      } else {
        print('Kesalahan: ${e.message}');
      }
      return null;
    } catch (e) {
      print('Kesalahan tidak diketahui: ${e.toString()}');
      return null;
    }
  }

  // Method untuk sign up dengan email dan password
  Future<UserModel?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return UserModel(uid: user!.uid, email: user.email!, name: user.displayName);
    } on FirebaseAuthException catch (e) {
      // Menangani berbagai jenis kesalahan Firebase Auth
      print('Kesalahan: ${e.message}');
      return null;
    } catch (e) {
      print('Kesalahan tidak diketahui: ${e.toString()}');
      return null;
    }
  }

  // Method untuk reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Kesalahan saat mengirim email reset password: ${e.toString()}');
    }
  }

  // Method untuk sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Kesalahan saat sign out: ${e.toString()}');
    }
  }

  // Method untuk sign in dengan Google
  Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential result = await _auth.signInWithCredential(credential);
        if (kDebugMode) {
          print("hasil : $result");
        }
        User? user = result.user;
        return UserModel(uid: user!.uid, email: user.email!, name: user.displayName);
      }
      return null;
    } catch (e) {
      print('Kesalahan saat sign in dengan Google: ${e.toString()}');
      return null;
    }
  }
}
