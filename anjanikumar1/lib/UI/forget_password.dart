import 'package:anjanikumar1/round_button.dart';
import 'package:anjanikumar1/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password?'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'Email',
            ),
          ),
          SizedBox(
            height: 40,
          ),
          RoundButton(
              title: 'Forget',
              onTap: (){
              auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value){
                Utils().toastMessage("We have sent the email to recover the password");
              }).onError((error, stackTrace){
                Utils().toastMessage(error.toString());
              });
              },
              loading: false
          )
        ],
      ),
    );
  }
}
