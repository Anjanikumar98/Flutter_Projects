// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    appId: '1:778984983203:web:c530058297727037fb4d16',
    messagingSenderId: '778984983203',
    projectId: 'healthsync-14b50',
    authDomain: 'healthsync-14b50.firebaseapp.com',
    storageBucket: 'healthsync-14b50.firebasestorage.app',
    measurementId: 'G-XK471KDN0Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: '',
    appId: '1:778984983203:android:adaf2d0c3f5f0025fb4d16',
    messagingSenderId: '778984983203',
    projectId: 'healthsync-14b50',
    storageBucket: 'healthsync-14b50.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '',
    appId: '1:778984983203:ios:637d8c0251d1e5fbfb4d16',
    messagingSenderId: '778984983203',
    projectId: 'healthsync-14b50',
    storageBucket: 'healthsync-14b50.firebasestorage.app',
    iosBundleId: 'com.example.healthsync',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: '',
    appId: '1:778984983203:ios:637d8c0251d1e5fbfb4d16',
    messagingSenderId: '778984983203',
    projectId: 'healthsync-14b50',
    storageBucket: 'healthsync-14b50.firebasestorage.app',
    iosBundleId: 'com.example.healthsync',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: '',
    appId: '1:778984983203:web:a7a054f499c55e09fb4d16',
    messagingSenderId: '778984983203',
    projectId: 'healthsync-14b50',
    authDomain: 'healthsync-14b50.firebaseapp.com',
    storageBucket: 'healthsync-14b50.firebasestorage.app',
    measurementId: 'G-8QSNJB67LN',
  );
}
