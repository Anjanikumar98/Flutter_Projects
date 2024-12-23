import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  String? _userId;
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;
  String? get userId => _userId;

  Future<void> login(String email, String password) async {
    // Simulate login delay
    await Future.delayed(Duration(seconds: 1));
    _userId = email;
    _isAuthenticated = true;
    notifyListeners();
  }

  Future<void> logout() async {
    _userId = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}