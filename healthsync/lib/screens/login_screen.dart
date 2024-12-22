// lib/screens/login_screen.dart
import 'package:flutter/material.dart';

import 'package:healthsync/services/auth_services.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // App logo/branding
              Image.asset('assets/logo.png', height: 150),

              // Email input field with validation
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        } else if (!RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$").hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    // Password input field with visibility toggle
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    // "Sign in with Google" button
                    ElevatedButton.icon(
                      onPressed: _signInWithGoogle,
                      icon: Icon(Icons.search),
                      label: Text('Sign in with Google'),
                    ),
                    SizedBox(height: 16),

                    // "Sign in with Email" button
                    ElevatedButton(
                      onPressed: _signInWithEmail,
                      child: Text('Sign in with Email'),
                    ),
                    SizedBox(height: 16),

                    // "Forgot Password?" link
                    TextButton(
                      onPressed: _forgotPassword,
                      child: Text('Forgot Password?'),
                    ),
                    SizedBox(height: 16),

                    // Registration link for new users
                    TextButton(
                      onPressed: _navigateToRegister,
                      child: Text('Don\'t have an account? Register'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signInWithEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      // Use FirebaseAuth for email/password authentication
      final authService = Provider.of<AuthService>(context, listen: false);
      await authService.signInWithEmail(email, password);

      // Redirect to dashboard after successful login
      Navigator.pushReplacementNamed(context, '/dashboard');
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Authentication failed. Please try again.';
      });
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      await authService.signInWithGoogle();

      // Redirect to dashboard after successful login
      Navigator.pushReplacementNamed(context, '/dashboard');
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Google Sign-In failed. Please try again.';
      });
    }
  }

  void _forgotPassword() {
    // Implement Forgot Password flow
    Navigator.pushNamed(context, '/forgot-password');
  }

  void _navigateToRegister() {
    // Navigate to registration screen
    Navigator.pushNamed(context, '/register');
  }
}
