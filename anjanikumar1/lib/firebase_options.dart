import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: '',
    appId: '1:755518872670:web:a82041f2ad64f374a4a8cf',
    messagingSenderId: '755518872670',
    projectId: 'anjanikumar1',
    authDomain: 'anjanikumar1.firebaseapp.com',
    storageBucket: 'anjanikumar1.firebasestorage.app',
    measurementId: 'G-H1Q1LDCN2Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA8DQbxNZXa-DptZ63-wSbv_G4ewYU3-m0',
    appId: '1:755518872670:android:d26f9b9dbd58d8a7a4a8cf',
    messagingSenderId: '755518872670',
    projectId: 'anjanikumar1',
    storageBucket: 'anjanikumar1.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDGNFIc4TifeM2ZGHdeI_BFTO33L2APqN0',
    appId: '1:755518872670:ios:b31c33c529a4da67a4a8cf',
    messagingSenderId: '755518872670',
    projectId: 'anjanikumar1',
    storageBucket: 'anjanikumar1.firebasestorage.app',
    iosBundleId: 'com.example.anjanikumar1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDGNFIc4TifeM2ZGHdeI_BFTO33L2APqN0',
    appId: '1:755518872670:ios:b31c33c529a4da67a4a8cf',
    messagingSenderId: '755518872670',
    projectId: 'anjanikumar1',
    storageBucket: 'anjanikumar1.firebasestorage.app',
    iosBundleId: 'com.example.anjanikumar1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCwobwg7J5vsfL5IxaAHhLNM1I7E5zqg28',
    appId: '1:755518872670:web:6e3c0b581d99667fa4a8cf',
    messagingSenderId: '755518872670',
    projectId: 'anjanikumar1',
    authDomain: 'anjanikumar1.firebaseapp.com',
    storageBucket: 'anjanikumar1.firebasestorage.app',
    measurementId: 'G-5MSRGMKC9G',
  );

}
