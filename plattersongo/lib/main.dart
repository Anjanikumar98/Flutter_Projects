import 'package:flutter/material.dart';

import 'Screens/platters_screen.dart';

void main() {
  runApp(PlatterApp());
}

class PlatterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PlatterEase',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Lato',
      ),
      home: PlattersScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
