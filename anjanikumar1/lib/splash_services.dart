import 'dart:async';

import 'package:anjanikumar1/UI/upload_image.dart';
import 'package:anjanikumar1/firestore/firestore_list_screen.dart';
import 'package:anjanikumar1/login_screen.dart';
import 'package:anjanikumar1/post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => UploadImage())));
    } else {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen())));
    }
  }
}
