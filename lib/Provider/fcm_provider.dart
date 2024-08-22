import 'package:flutter/material.dart';
import '../Services/fcm_service.dart';

class NotificationProvider with ChangeNotifier {
  final FCMService _fcmService = FCMService();
  bool _isSubscribed = false;
  bool _notifStatus = false;
  bool get notifStatus => _notifStatus;

  bool get isSubscribed => _isSubscribed;

  NotificationProvider() {
    initializeNotifications(); // Panggil saat provider diinisialisasi
  }

  // Mengambil status notifikasi dari Firestore
  Future<void> fetchNotificationStatus(String userId) async {
    try {
      _notifStatus = await _fcmService.getNotificationStatus(userId);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  // Mengubah status notifikasi dan update di Firestore
  Future<void> updateNotificationStatus(String userId, bool status) async {
    try {
      _notifStatus = status;
      await _fcmService.updateNotificationStatus(userId, status);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> toggleSubscription(String topic) async {
    if (_isSubscribed) {
      await _fcmService.unsubscribeFromTopic(topic);
      print("unsub");
      _isSubscribed = false;
      print(_isSubscribed);
    } else {
      await _fcmService.subscribeToTopic(topic);
      print("sub");
      print(_isSubscribed);
      _isSubscribed = true;
      print(_isSubscribed);
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
  
    notifyListeners();
  }

  // Initialize notification handling for foreground messages
  void initializeNotifications() {
    _fcmService.handleForegroundNotifications();
    FCMService.localNotiInit();
  }
}
