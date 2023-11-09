// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyB651gwZuiQCcwUrtsmrQJLX_6aQcB_1p0',
    appId: '1:622941368501:web:c3c5f364b1d8f63114cefc',
    messagingSenderId: '622941368501',
    projectId: 'fir-database-d8e5c',
    authDomain: 'fir-database-d8e5c.firebaseapp.com',
    storageBucket: 'fir-database-d8e5c.appspot.com',
    measurementId: 'G-L6CMC7L3WP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJ3ctQujYSvwsY_b_6QxdHgD905C_KKqU',
    appId: '1:622941368501:android:7238f23a7f89068a14cefc',
    messagingSenderId: '622941368501',
    projectId: 'fir-database-d8e5c',
    storageBucket: 'fir-database-d8e5c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA9y1lzu11aqyO42aMduu8aQrKCaJuyNGY',
    appId: '1:622941368501:ios:ba59a365edf8952114cefc',
    messagingSenderId: '622941368501',
    projectId: 'fir-database-d8e5c',
    storageBucket: 'fir-database-d8e5c.appspot.com',
    iosBundleId: 'com.example.firebaseDatabase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA9y1lzu11aqyO42aMduu8aQrKCaJuyNGY',
    appId: '1:622941368501:ios:4d5f01a15d16f2c314cefc',
    messagingSenderId: '622941368501',
    projectId: 'fir-database-d8e5c',
    storageBucket: 'fir-database-d8e5c.appspot.com',
    iosBundleId: 'com.example.firebaseDatabase.RunnerTests',
  );
}
