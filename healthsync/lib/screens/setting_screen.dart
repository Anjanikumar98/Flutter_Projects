// lib/screens/settings_screen.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'health_service.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _imagePicker = ImagePicker();
  String? _profileImageUrl;
  String _userName = 'John Doe';
  String _userEmail = 'john.doe@example.com';
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  String _unitsPreference = 'Metric';
  int _stepGoal = 10000;
  int _heartRateZone = 75;
  int _syncFrequency = 15; // In minutes
  bool _isBluetoothConnected = false;

  @override
  void initState() {
    super.initState();
    // Load settings (you can add your actual logic here)
  }

  // Method to pick profile image
  Future<void> _pickProfileImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImageUrl = pickedFile.path;
      });
    }
  }

  // Method to handle theme toggle
  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  // Method to handle Bluetooth connection
  void _connectBluetooth() {
    // Implement Bluetooth connection logic
    setState(() {
      _isBluetoothConnected = !_isBluetoothConnected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final healthService = Provider.of<HealthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // User Profile Section
            GestureDetector(
              onTap: _pickProfileImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _profileImageUrl != null
                    ? FileImage(File(_profileImageUrl!))
                    : AssetImage('assets/images/default_avatar.png') as ImageProvider,
              ),
            ),
            SizedBox(height: 16),
            Text(_userName, style: TextStyle(fontSize: 22)),
            Text(_userEmail, style: TextStyle(fontSize: 16, color: Colors.grey)),
            ElevatedButton(
              onPressed: () {
                // Implement edit profile logic
              },
              child: Text('Edit Profile'),
            ),
            Divider(),

            // Device Management Section
            ListTile(
              title: Text('Bluetooth Device'),
              subtitle: Text(_isBluetoothConnected ? 'Connected' : 'Not Connected'),
              trailing: ElevatedButton(
                onPressed: _connectBluetooth,
                child: Text(_isBluetoothConnected ? 'Disconnect' : 'Connect'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement pair new device logic
              },
              child: Text('Pair New Device'),
            ),
            Divider(),

            // App Preferences Section
            SwitchListTile(
              title: Text('Dark/Light Theme'),
              value: _isDarkMode,
              onChanged: _toggleTheme,
            ),
            ListTile(
              title: Text('Notification Settings'),
              trailing: Switch(
                value: _notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Data Sync Frequency'),
              subtitle: Text('Every $_syncFrequency minutes'),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Implement sync frequency change logic
                },
              ),
            ),
            ListTile(
              title: Text('Units Preference'),
              subtitle: Text(_unitsPreference),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Implement units preference change logic
                },
              ),
            ),
            Divider(),

            // Health Goals Section
            ListTile(
              title: Text('Daily Step Goal'),
              subtitle: Text('$_stepGoal steps'),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Implement step goal change logic
                },
              ),
            ),
            ListTile(
              title: Text('Heart Rate Zone'),
              subtitle: Text('$_heartRateZone%'),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Implement heart rate zone change logic
                },
              ),
            ),
            ListTile(
              title: Text('Activity Reminder'),
              trailing: Switch(
                value: _notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
              ),
            ),
            Divider(),

            // Data Management Section
            ListTile(
              title: Text('Clear Local Data'),
              onTap: () {
                // Implement local data clearing logic
              },
            ),
            ListTile(
              title: Text('Backup Settings'),
              onTap: () {
                // Implement backup settings logic
              },
            ),
            ListTile(
              title: Text('Privacy Settings'),
              onTap: () {
                // Implement privacy settings logic
              },
            ),
            Divider(),

            // Account Management Section
            ListTile(
              title: Text('Change Password'),
              onTap: () {
                // Implement change password logic
              },
            ),
            ListTile(
              title: Text('Delete Account'),
              onTap: () {
                // Implement delete account logic
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Implement logout logic
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
