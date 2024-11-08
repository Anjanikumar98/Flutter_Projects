import 'package:anjanikumar1/round_button.dart';
import 'package:anjanikumar1/utils.dart';
import 'package:anjanikumar1/verify_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  bool loading = false;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  // Function to verify phone number and send OTP
  void _verifyPhone() {
    final phoneNumber = phoneNumberController.text.trim();

    // Validate phone number format before proceeding
    if (!RegExp(r'^\+\d{1,3}\d{9,}$').hasMatch(phoneNumber)) {
      Utils().toastMessage("Please enter a valid phone number with country code, e.g., +912345678910");
      setState(() => loading = false);
      return;
    }

    setState(() => loading = true);

    // Firebase phone authentication
    auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) async {
        await auth.signInWithCredential(phoneAuthCredential);
        setState(() => loading = false);
        Utils().toastMessage("Phone number verified!");
        Navigator.pushReplacementNamed(context, '/home'); // Navigate to home screen
      },
      verificationFailed: (e) {
        Utils().toastMessage(e.message ?? "Phone verification failed");
        setState(() => loading = false);
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyCodeScreen(verificationId: verificationId),
          ),
        );
        setState(() => loading = false);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        Utils().toastMessage("Code retrieval timed out. Please try again.");
        setState(() => loading = false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login with Phone'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 70),
            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: '+91 234 5678 989',
                labelText: 'Phone Number',
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: 30),
            RoundButton(
              title: 'Login',
              loading: loading,
              onTap: _verifyPhone, // Call the _verifyPhone function on button press
            ),
          ],
        ),
      ),
    );
  }
}
