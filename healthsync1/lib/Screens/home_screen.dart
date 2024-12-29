import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_services.dart';
import '../services/health_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final healthService = Provider.of<HealthService>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (authService.isAuthenticated)
              Text('Welcome, ${authService.userId}'),
            if (!authService.isAuthenticated)
              Text('Not authenticated'),

            SizedBox(height: 20),
            if (healthService.isConnected)
              Column(
                children: [
                  Text('Heart Rate: ${healthService.currentHeartRate}'),
                  Text('Step Count: ${healthService.stepCount}'),
                ],
              ),
            if (!healthService.isConnected)
              Text('No device connected'),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                authService.logout();
                healthService.stopMonitoring();
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
