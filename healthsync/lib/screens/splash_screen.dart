import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_services.dart';
import '../services/health_service.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Initialize HealthService (initialize method is part of HealthService)
    final healthService = Provider.of<HealthService>(context, listen: false);
    healthService.initialize(); // Initialize HealthService (e.g., mock Bluetooth connection)

    // Simulate login for AuthService (no initialize method needed)
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.login('testUser', 'password'); // Mock login for demonstration

    // Navigate to the home screen after initialization
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Health Sync')),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
