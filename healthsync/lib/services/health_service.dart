import 'package:flutter/material.dart';

class HealthService with ChangeNotifier {
  bool _isConnected = false;
  int _currentHeartRate = 0;
  int _stepCount = 0;

  bool get isConnected => _isConnected;
  int get currentHeartRate => _currentHeartRate;
  int get stepCount => _stepCount;

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
}
