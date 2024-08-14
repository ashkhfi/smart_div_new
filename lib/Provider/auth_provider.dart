import 'package:flutter/material.dart';
import 'package:smart_div_new/Services/user_service.dart';
import '../Models/user_model.dart';
import '../Services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();
  UserModel? _user;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Method untuk sign in
  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    try {
      _user = await _authService.signInWithEmailAndPassword(email, password);
      _errorMessage = null;
      print(_user);
      if (_user == null) {
        _errorMessage = "Eror";
        print(_errorMessage);
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
    notifyListeners();
    return _user != null;
  }

  // Method untuk sign up
  Future<bool> signUp(String email, String password) async {
    _setLoading(true);
    try {
      _user = await _authService.signUpWithEmailAndPassword(email, password);
      _errorMessage = null;

      await _userService.addUser(
        _user!.uid,
        _user!.toJson(),
      );
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
    notifyListeners();
    return _user != null;
  }

  // Method untuk sign in dengan Google
  Future<void> signInWithGoogle() async {
    _setLoading(true);
    try {
      _user = await _authService.signInWithGoogle();
      _errorMessage = null;
      bool isEmailAvailable = await _userService.isEmailAvailable(_user!.email);
      if (isEmailAvailable == false) {
        await _userService.addUser(
          _user!.uid,
          _user!.toJson(),
        );
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  // Method untuk reset password
  Future<void> resetPassword(String email) async {
    _setLoading(true);
    try {
      await _authService.resetPassword(email);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e
          .toString(); // Menyimpan pesan kesalahan yang diterima dari AuthService
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  // Method untuk sign out
  Future<void> signOut() async {
    _setLoading(true);
    try {
      await _authService.signOut();
      _user = null;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e
          .toString(); 
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
