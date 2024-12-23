import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'mock_bluetooth_sdk.dart';

class HealthService extends ChangeNotifier {
  final MockBluetoothSDK _sdk = MockBluetoothSDK();
  bool _isConnected = false;
  int _currentHeartRate = 0;
  int _stepCount = 0;
  StreamSubscription? _heartRateSubscription;
  StreamSubscription? _stepCountSubscription;

  bool get isConnected => _isConnected;
  int get currentHeartRate => _currentHeartRate;
  int get stepCount => _stepCount;

  void initialize() {
    _isConnected = true;
    _startMonitoring();
    notifyListeners();
  }

  void _startMonitoring() {
    _heartRateSubscription = _sdk.getHeartRateStream().listen((heartRate) {
      _currentHeartRate = heartRate;
      notifyListeners();
    });

    _stepCountSubscription = _sdk.getStepCountStream().listen((steps) {
      _stepCount = steps;
      notifyListeners();
    });
  }

  void stopMonitoring() {
    _heartRateSubscription?.cancel();
    _stepCountSubscription?.cancel();
    _isConnected = false;
    notifyListeners();
  }

  @override
  void dispose() {
    stopMonitoring();
    super.dispose();
  }
}
