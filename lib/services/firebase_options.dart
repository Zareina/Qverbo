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
    apiKey: 'AIzaSyAGiQ7PEbtZU7vRB0G81kZxtVSrMN7e-00',
    appId: '1:35972566479:web:8f28544e1fa41330da16ba',
    messagingSenderId: '35972566479',
    projectId: 'qvrbo-63dff',
    authDomain: 'qvrbo-63dff.firebaseapp.com',
    storageBucket: 'qvrbo-63dff.appspot.com',
    measurementId: 'G-BJTM07NJ9G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAzNfI6SPPM6aRSKVXT_dFHD1M7yyEucqA',
    appId: '1:35972566479:android:9f12d1eefdfa0d47da16ba',
    messagingSenderId: '35972566479',
    projectId: 'qvrbo-63dff',
    storageBucket: 'qvrbo-63dff.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBrqHX2FW7rQRfPyY94WuboA_NfbHS36O0',
    appId: '1:35972566479:ios:0f24f664851ffc73da16ba',
    messagingSenderId: '35972566479',
    projectId: 'qvrbo-63dff',
    storageBucket: 'qvrbo-63dff.appspot.com',
    iosBundleId: 'com.example.qverbo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBrqHX2FW7rQRfPyY94WuboA_NfbHS36O0',
    appId: '1:35972566479:ios:96dd9e573442c620da16ba',
    messagingSenderId: '35972566479',
    projectId: 'qvrbo-63dff',
    storageBucket: 'qvrbo-63dff.appspot.com',
    iosBundleId: 'com.example.qverbo.RunnerTests',
  );
}