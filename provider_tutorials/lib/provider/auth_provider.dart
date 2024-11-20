import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  bool _loading = false;
  String? _error;

  bool get loading => _loading;
  String? get error => _error;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void setError(String? value) {
    _error = value;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    setLoading(true);
    setError(null);
    try {
      final response = await http.post(
        Uri.parse('https://reqres.in/api/login'),
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        print('Successful login');
        setLoading(false);
        return true; // Indicate success
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        setError(errorData['error'] ?? 'Login failed');
        setLoading(false);
        print('Failed: ${errorData['error']}');
        return false; // Indicate failure
      }
    } catch (e) {
      setError('An unexpected error occurred');
      setLoading(false);
      print('Error: ${e.toString()}');
      return false; // Indicate failure
    }
  }
}
