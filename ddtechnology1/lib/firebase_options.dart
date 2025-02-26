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
    apiKey: 'AIzaSyDEWM5Ri5uctVDsZf0o1AgIBY_h3FQWBdA',
    appId: '1:970641443966:web:6e5a3026264751a381dc2f',
    messagingSenderId: '970641443966',
    projectId: 'dtechnology-3b0a6',
    authDomain: 'dtechnology-3b0a6.firebaseapp.com',
    storageBucket: 'dtechnology-3b0a6.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBtPVr_j51pkGL7SmsWDWUAY-a1PZJt_NU',
    appId: '1:970641443966:android:301f26bdfadac9a481dc2f',
    messagingSenderId: '970641443966',
    projectId: 'dtechnology-3b0a6',
    storageBucket: 'dtechnology-3b0a6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAqYJ_EEPha_-nJPj5c12BrKvvNtv-jJ28',
    appId: '1:970641443966:ios:473c0b9d5064539581dc2f',
    messagingSenderId: '970641443966',
    projectId: 'dtechnology-3b0a6',
    storageBucket: 'dtechnology-3b0a6.appspot.com',
    iosBundleId: 'com.example.ddtechnology1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAqYJ_EEPha_-nJPj5c12BrKvvNtv-jJ28',
    appId: '1:970641443966:ios:473c0b9d5064539581dc2f',
    messagingSenderId: '970641443966',
    projectId: 'dtechnology-3b0a6',
    storageBucket: 'dtechnology-3b0a6.appspot.com',
    iosBundleId: 'com.example.ddtechnology1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDEWM5Ri5uctVDsZf0o1AgIBY_h3FQWBdA',
    appId: '1:970641443966:web:8afb9539edcda61b81dc2f',
    messagingSenderId: '970641443966',
    projectId: 'dtechnology-3b0a6',
    authDomain: 'dtechnology-3b0a6.firebaseapp.com',
    storageBucket: 'dtechnology-3b0a6.appspot.com',
  );

}