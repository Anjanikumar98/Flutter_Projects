import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // To pick images from gallery or camera
import 'dart:io';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  // Function to pick an image from the gallery or camera
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to take a picture from the camera
  Future<void> _takePicture() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture Section
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? Icon(Icons.person, size: 50)
                    : null,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image from Gallery'),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: _takePicture,
                child: Text('Take Picture with Camera'),
              ),
            ),
            SizedBox(height: 30),

            // Other Settings Section
            Text('Other Settings'),
            SwitchListTile(
              title: Text('Enable Notifications'),
              value: true, // You can bind this to an actual setting
              onChanged: (bool value) {},
            ),
            ListTile(
              title: Text('Change Password'),
              onTap: () {
                // Navigate to a Change Password screen (if any)
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                // Implement Logout functionality (e.g., Firebase Auth sign-out)
              },
            ),
          ],
        ),
      ),
    );
  }
}