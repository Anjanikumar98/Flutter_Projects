import 'package:flutter/material.dart';

<<<<<<< HEAD
class AuthService extends ChangeNotifier {
  String? _userId;
  bool _isAuthenticated = false;
=======
class AuthService with ChangeNotifier {
  bool _isAuthenticated = false;
  String? _userId;
>>>>>>> 3a75b38f247e9fae238563409d48799b5cb95697

  bool get isAuthenticated => _isAuthenticated;
  String? get userId => _userId;

<<<<<<< HEAD
  Future<void> login(String email, String password) async {
    // Simulate login delay
    await Future.delayed(Duration(seconds: 1));
    _userId = email;
    _isAuthenticated = true;
=======
  Future<void> login(String username, String password) async {
    // Simulate an API call
    await Future.delayed(Duration(seconds: 2));
    _isAuthenticated = true;
    _userId = "user123"; // Mock user ID
>>>>>>> 3a75b38f247e9fae238563409d48799b5cb95697
    notifyListeners();
  }

  Future<void> logout() async {
<<<<<<< HEAD
    _userId = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}
=======
    _isAuthenticated = false;
    _userId = null;
    notifyListeners();
  }
}
>>>>>>> 3a75b38f247e9fae238563409d48799b5cb95697
