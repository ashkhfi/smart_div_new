import 'package:flutter/material.dart';
import '../Services/fcm_service.dart';

class NotificationProvider with ChangeNotifier {
  final FCMService _fcmService = FCMService();
  bool _isSubscribed = false;

  bool get isSubscribed => _isSubscribed;

  NotificationProvider() {
    initializeNotifications(); // Panggil saat provider diinisialisasi
  }

  Future<void> toggleSubscription(String topic) async {
    if (_isSubscribed) {
      await _fcmService.unsubscribeFromTopic(topic);
      _isSubscribed = false;
    } else {
      await _fcmService.subscribeToTopic(topic);
      _isSubscribed = true;
    }
    notifyListeners();
  }

  void setSubscriptionStatus(bool status) {
    _isSubscribed = status;
    notifyListeners();
  }

  Future<void> logout(String topic) async {
    if (_isSubscribed) {
      await _fcmService.unsubscribeFromTopic(topic);
      _isSubscribed = false;
    }
    // Tambahkan logika lain untuk logout seperti membersihkan token, dll.
    notifyListeners();
  }

  // Initialize notification handling for foreground messages
  void initializeNotifications() {
    _fcmService.handleForegroundNotifications();
    FCMService.localNotiInit();
  }
}
