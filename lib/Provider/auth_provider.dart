import 'package:flutter/material.dart';
import 'package:smart_div_new/Services/user_service.dart';
import '../Models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    try {
      _user = await _authService.signInWithEmailAndPassword(email, password);
      _errorMessage = null;
      final prefs = await SharedPreferences.getInstance();
      String? uid = await _authService.getCurrentUser();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('uid', uid!);
      var a = await prefs.getString('uid');
      print("uid  = ${a}");
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

      _user?.image =
          'https://firebasestorage.googleapis.com/v0/b/smartgridv2.appspot.com/o/users%2Fplaceholder.jpg?alt=media&token=397a648f-9b2b-41c2-8c37-59a64fb2e60b';
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

  Future<void> signInWithGoogle() async {
    _setLoading(true);
    try {
      _user = await _authService.signInWithGoogle();
      _errorMessage = null;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      String? uid = await _authService.getCurrentUser();
      await prefs.setString('uid', uid!);
      var a = await prefs.getString('uid');
      print("uid  = ${a}");
      bool isEmailAvailable = await _userService.isEmailAvailable(_user!.email);
      if (isEmailAvailable == false) {
        _user?.image =
            'https://firebasestorage.googleapis.com/v0/b/smartgridv2.appspot.com/o/users%2Fplaceholder.jpg?alt=media&token=397a648f-9b2b-41c2-8c37-59a64fb2e60b';
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
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  // Method untuk sign out

  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool? isLogin = prefs.getBool('isLoggedIn');
    // String? uid = await _authService.getCurrentUser();
    if (isLogin == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> signOut() async {
    _setLoading(true);
    try {
      await _authService.signOut();
      _user = null;
      _errorMessage = null;
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('isLoggedIn');
      await prefs.remove('uid');
    } catch (e) {
      _errorMessage = e.toString();
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
