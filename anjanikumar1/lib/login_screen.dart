import 'package:anjanikumar1/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:anjanikumar1/round_button.dart'; // Custom round button widget
import 'package:anjanikumar1/utils.dart'; // Custom utility for showing messages
import 'package:anjanikumar1/login_with_phone.dart'; // Phone login screen

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Email and Password login
  void _loginWithEmailPassword() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Utils().toastMessage('Please enter both email and password');
      return;
    }

    setState(() => loading = true);

    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      setState(() => loading = false);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => PostScreen())); // Navigate to PostScreen
    } catch (e) {
      setState(() => loading = false);
      Utils().toastMessage(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 20),
            RoundButton(
              title: 'Login with Email',
              loading: loading,
              onTap: _loginWithEmailPassword,
            ),
            const SizedBox(height: 20),
            Divider(color: Colors.grey),
            const SizedBox(height: 20),
            RoundButton(
              title: 'Login with Phone Number',
              loading: loading,
              onTap: () {
                // Navigate to the phone number login screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginWithPhone(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
