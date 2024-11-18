import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'profile_selection_screen.dart';

class VerifyPhoneScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;

  const VerifyPhoneScreen({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
  });

  @override
  _VerifyPhoneScreenState createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // List to hold each OTP digit
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());

  // Loading state
  bool _isLoading = false;

  // Timer for Resend OTP
  int _resendTimeout = 30; // 30 seconds
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startResendCountdown();
  }

  // Start countdown for resend OTP
  void _startResendCountdown() {
    setState(() {
      _canResend = false;
      _resendTimeout = 30;
    });

    Future.delayed(const Duration(seconds: 1), () async {
      while (_resendTimeout > 0) {
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          _resendTimeout--;
        });
      }
      setState(() {
        _canResend = true;
      });
    });
  }

  // Verify OTP entered by the user
  void _verifyOtp() async {
    String otp = _otpControllers.map((controller) => controller.text).join();

    if (otp.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter a 6-digit OTP")));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Create a PhoneAuthCredential using the verificationId and OTP entered
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      // Sign in with the credential
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Phone number verified successfully!")));

        // Navigate to Profile Selection Screen after successful OTP verification
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const ProfileSelectionScreen()),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Verification failed")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Resend OTP functionality
  void _resendOtp() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          print("Verification completed automatically.");
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Verification failed: ${e.message}")),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("OTP resent successfully!")),
          );
          setState(() {
            _isLoading = false;
          });
          _startResendCountdown();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print("Auto-retrieval timeout: $verificationId");
          setState(() {
            _isLoading = false;
          });
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error resending OTP. Please try again.")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Enter OTP", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title
            const Text(
              "OTP Verification",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              "We sent an OTP to your phone. \n Please enter it below to verify.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),

            // OTP input fields (6 boxes)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 40,
                  child: TextField(
                    controller: _otpControllers[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.blueAccent),
                      ),
                      filled: true,
                      fillColor: Colors.blue[50],
                    ),
                    maxLength: 1,
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 5) {
                        FocusScope.of(context).nextFocus();
                      }
                      if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),

            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Didn't receive the code? ",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  TextSpan(
                    text: _canResend
                        ? "Request Again"
                        : "Wait $_resendTimeout seconds",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                    recognizer: TapGestureRecognizer()
                      ..onTap = _canResend ? _resendOtp : null,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Verify OTP button
            ElevatedButton(
              onPressed: _isLoading ? null : _verifyOtp,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      "Verify OTP",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
