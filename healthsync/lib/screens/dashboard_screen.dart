// lib/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:healthsync/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/scheduler.dart';

import 'health_service.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    // Auto-refresh data when screen is loaded
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _refreshData();
    });
  }

  Future<void> _refreshData() async {
    setState(() {
      _isRefreshing = true;
    });

    // Call the HealthService to sync data
    await Provider.of<HealthService>(context, listen: false).startMonitoring();

    setState(() {
      _isRefreshing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final healthService = Provider.of<HealthService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User profile section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage('https://example.com/user_profile_picture.jpg'),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Last Sync: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now())}',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Real-time health metrics cards
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text('Heart Rate'),
                    subtitle: Text('${healthService.currentHeartRate} BPM'),
                    trailing: Text('Normal'),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.directions_walk),
                    title: Text('Step Count'),
                    subtitle: Text('${healthService.stepCount} steps'),
                    trailing: CircularProgressIndicator(
                      value: healthService.stepCount / 10000, // 10,000 is the goal
                    ),
                  ),
                ),
              ),

              // Bluetooth connection status indicator
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      healthService.isConnected ? Icons.bluetooth_connected : Icons.bluetooth_disabled,
                      color: healthService.isConnected ? Colors.green : Colors.red,
                    ),
                    SizedBox(width: 8),
                    Text(
                      healthService.isConnected ? 'Connected to Bluetooth' : 'Bluetooth Disconnected',
                      style: TextStyle(color: healthService.isConnected ? Colors.green : Colors.red),
                    ),
                  ],
                ),
              ),

              // Quick actions toolbar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _syncData,
                      icon: Icon(Icons.sync),
                      label: Text('Sync Data'),
                    ),
                    ElevatedButton.icon(
                      onPressed: _toggleMonitoring,
                      icon: Icon(healthService.isConnected ? Icons.pause : Icons.play_arrow),
                      label: Text(healthService.isConnected ? 'Stop Monitoring' : 'Start Monitoring'),
                    ),
                    ElevatedButton.icon(
                      onPressed: _emergencyContact,
                      icon: Icon(Icons.phone),
                      label: Text('Emergency'),
                    ),
                  ],
                ),
              ),

              // Heart rate visualization
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text('Heart Rate Visualization'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Current BPM: ${healthService.currentHeartRate}'),
                        // Add your graph here (example)
                        Container(height: 150, color: Colors.grey[200]),
                        Text('Heart Rate Zones: Normal'),
                      ],
                    ),
                  ),
                ),
              ),

              // Step counter
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.directions_walk),
                    title: Text('Step Counter'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Today\'s steps: ${healthService.stepCount}'),
                        LinearProgressIndicator(
                          value: healthService.stepCount / 10000, // 10,000 is the goal
                        ),
                        Text('Previous day: 5,000 steps'),
                      ],
                    ),
                  ),
                ),
              ),

              // Daily statistics summary
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.assessment),
                    title: Text('Daily Statistics'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Average Heart Rate: 72 BPM'),
                        Text('Total Active Minutes: 120 mins'),
                        Text('Calories Burned: 500 kcal'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _syncData() async {
    // Implement sync data functionality here
    // Sync health data with backend or cloud service
    setState(() {
      // Show progress indicator while syncing
    });
  }

  Future<void> _toggleMonitoring() async {
    final healthService = Provider.of<HealthService>(context, listen: false);
    if (healthService.isConnected) {
      // Stop monitoring
      healthService.stopMonitoring();
    } else {
      // Start monitoring
      healthService.startMonitoring();
    }
  }

  void _emergencyContact() {
    // Implement emergency contact functionality
    // For example, open the phone dialer
  }
}
