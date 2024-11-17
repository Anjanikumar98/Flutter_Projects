import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final String profile;

  const WelcomeScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile picture section (example placeholder)
            CircleAvatar(
              radius: 60,
              backgroundImage:
                  const AssetImage('assets/images/profile_placeholder.png'),
              backgroundColor: Colors.blue[100],
            ),
            const SizedBox(height: 20),

            // Profile name & greeting
            Text(
              "Welcome, $profile!",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "We are glad to have you on board. Let's get started with your journey.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 30),

            // Continue button
            ElevatedButton(
              onPressed: () {
                // Add navigation or logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Let's Get Started",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Footer with app logo or other info
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                "LiveasyAuthApp © 2024",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
