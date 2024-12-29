<<<<<<< HEAD
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
=======
import 'package:flutter/material.dart';

class HealthService with ChangeNotifier {
  bool _isConnected = false;
  int _currentHeartRate = 0;
  int _stepCount = 0;
>>>>>>> 3a75b38f247e9fae238563409d48799b5cb95697

  bool get isConnected => _isConnected;
  int get currentHeartRate => _currentHeartRate;
  int get stepCount => _stepCount;

<<<<<<< HEAD
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
=======
  // Initialize Health Service
  Future<void> initialize() async {
    // Simulate data initialization
    _currentHeartRate = 72;  // Mock heart rate data
    _stepCount = 1000;  // Mock step count data
    _isConnected = true;  // Mock connection status
    notifyListeners();
  }

  // Start monitoring (simulate Bluetooth streaming)
  void startMonitoring() {
    // Simulate heart rate and step count updates
    _currentHeartRate = 75;  // Update with mock data
    _stepCount = 1500;  // Update with mock data
    notifyListeners();
  }

  void stopMonitoring() {
    _isConnected = false;
    notifyListeners();
  }
>>>>>>> 3a75b38f247e9fae238563409d48799b5cb95697
}
