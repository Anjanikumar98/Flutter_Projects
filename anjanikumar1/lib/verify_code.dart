import 'package:anjanikumar1/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final otpController = TextEditingController();
  bool loading = false;

  final auth = FirebaseAuth.instance;

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  void _verifyOTP() async {
    final otp = otpController.text.trim();
    if (otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter the OTP")));
      return;
    }

    setState(() => loading = true);

    try {
      // Create a phone credential using the entered OTP and verification ID
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      // Sign in with the credential
      await auth.signInWithCredential(credential);
      setState(() => loading = false);

      // Navigate to the next screen after successful login
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid OTP")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter OTP')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            TextFormField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter OTP',
                labelText: 'OTP',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 30),
            RoundButton(
              title: 'Verify OTP',
              loading: loading,
              onTap: _verifyOTP, // Call the _verifyOTP function on button press
            ),
          ],
        ),
      ),
    );
  }
}
