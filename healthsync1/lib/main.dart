import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healthsync1/services/auth_services.dart';
import 'package:healthsync1/services/health_service.dart';
import 'package:provider/provider.dart';

import 'Screens/dashboard_screen.dart';
import 'Screens/history_screen.dart';
import 'Screens/login_screen.dart';
import 'Screens/setting_screen.dart';
import 'Screens/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => HealthService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Monitor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/history': (context) => HistoryScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}