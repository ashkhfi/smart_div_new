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

  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _sensor = await _sensorService.getData();
      _errorMessage = null;
    } catch (e) {
      _sensor = null;
      _errorMessage = 'Error fetching data: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
