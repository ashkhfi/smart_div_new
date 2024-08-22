import 'package:flutter/foundation.dart';
import 'package:smart_div_new/Models/sensor_model.dart';
import 'package:smart_div_new/Services/sensor_service.dart';

class SensorProvider with ChangeNotifier {
  final SensorService _sensorService = SensorService();
  sensorModel? _sensor;
  bool _isLoading = false;
  String? _errorMessage;

  sensorModel? get sensor => _sensor;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  SensorProvider() {
    // Memulai stream untuk mendengarkan data secara realtime
    getDataSensor();
  }

  void getDataSensor() {
    _isLoading = true;
    notifyListeners();

    try {
      _sensorService.streamData().listen((sensorData) {
        _sensor = sensorData;
        _isLoading = false;
        _errorMessage = null;
        notifyListeners();
      });
    } catch (e) {
      _sensor = null;
      _isLoading = false;
      _errorMessage = 'Error streaming data: $e';
      notifyListeners();
    }
  }

  void updateRelay(String commandAndroid) async {
    await _sensorService.updateRelayStatus(commandAndroid);
  }
}
