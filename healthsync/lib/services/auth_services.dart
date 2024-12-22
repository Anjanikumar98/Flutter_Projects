import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  bool _isAuthenticated = false;
  String? _userId;

  bool get isAuthenticated => _isAuthenticated;
  String? get userId => _userId;

  Future<void> login(String username, String password) async {
    // Simulate an API call
    await Future.delayed(Duration(seconds: 2));
    _isAuthenticated = true;
    _userId = "user123"; // Mock user ID
    notifyListeners();
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    _userId = null;
    notifyListeners();
  }
}
