// lib/services/health_service.dart
import 'package:flutter/foundation.dart';


class HealthService extends ChangeNotifier {
  final MockBluetoothSDK _sdk = MockBluetoothSDK();
  bool _isConnected = false;
  int _currentHeartRate = 0;
  int _stepCount = 0;

  bool get isConnected => _isConnected;
  int get currentHeartRate => _currentHeartRate;
  int get stepCount => _stepCount;

  void startMonitoring() {
    _isConnected = true;

    _sdk.getHeartRateStream().listen((heartRate) {
      _currentHeartRate = heartRate;
      notifyListeners();
    });

    _sdk.getStepCountStream().listen((steps) {
      _stepCount = steps;
      notifyListeners();
    });
  }

  void stopMonitoring() {
    _isConnected = false;
    notifyListeners();
  }
}