import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int count = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    // Initialize the Timer to increment count every second
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        count++; // Update the count and trigger UI rebuild
      });
    });
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anjanikumar'),
      ),
      body: Center(
        child: Text(
          "${DateTime.now().hour}:"
          "${DateTime.now().minute}:"
          "${DateTime.now().second}",
          style: const TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
