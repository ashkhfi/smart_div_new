import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_div_new/Models/user_model.dart';
import '../Services/auth_service.dart';
import '../Services/user_service.dart';

class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();
  final AuthService _authService = AuthService();
  UserModel? _userData;
  bool _isLoading = false;

  UserModel? get userData => _userData;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }



  Future<bool> isLoggedIn() async {
    final user = _authService.getCurrentUser();
    return user != null;
  }

  Future<void> loadUserData(String userId) async {
    // _setLoading(true);
    Map<String, dynamic>? userJson = await _userService.getUser(userId);
    if (userJson != null) {
      _userData = UserModel.fromJson(userJson);
      print("berhasil get data user a");
    } else {
      _userData = null;
    }
    // _setLoading(false);
  }

  Future<void> addUser(String userId, UserModel userModel) async {
    _setLoading(true);
    await _userService.addUser(userId, userModel.toJson());
    if (_userData != null && _userData!.uid == userId) {
      _userData = userModel;
    }
    _setLoading(false);
  }

  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    _setLoading(true);
    await _userService.updateUser(userId, data);
    if (_userData != null && _userData!.uid == userId) {
      _userData = UserModel(
        uid: _userData!.uid,
        email: _userData!.email,
        name: data['name'] ?? _userData!.name,
        image: data['image'] ?? _userData!.image,
        jabatan: data['jabatan'] ?? _userData!.jabatan,
      );
    }
    _setLoading(false);
  }

  Future<void> uploadAndSetUserImage(String userId, String imgUrl) async {
    _setLoading(true);

    await updateUser(userId, {'image': imgUrl});
    _setLoading(false);
  }

  void setName(String? newName) {
    if (_userData != null) {
      _userData!.name = newName ?? "";
      notifyListeners();
    }
  }

  Future<String> uploadImage(String userId, XFile imgUrl) async {
    String? imageUrl =
        await _userService.uploadImage(File(imgUrl.path), userId);
    return imageUrl ?? "";
  }

  Future<void> clearUserData() async {
    _userData = null;
    notifyListeners();
  }
}
