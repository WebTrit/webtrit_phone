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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBcL0PtdiRbbWrAji5K_IbV71hpO_wocUQ',
    appId: '1:567844538132:web:7aa39595ef4d1a18162401',
    messagingSenderId: '567844538132',
    projectId: 'webtrit-voip-softphone',
    authDomain: 'webtrit-voip-softphone.firebaseapp.com',
    storageBucket: 'webtrit-voip-softphone.appspot.com',
    measurementId: 'G-JH0F7266BG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAJDMbIDIEVP7GXTXF9bqTkLbyxICG6WiQ',
    appId: '1:567844538132:android:6c34223f0e1a9c5c162401',
    messagingSenderId: '567844538132',
    projectId: 'webtrit-voip-softphone',
    storageBucket: 'webtrit-voip-softphone.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB6MTtyeYb1XZPU_QMBKJ2YtAWWbLT4we8',
    appId: '1:567844538132:ios:2b49981b575ee389162401',
    messagingSenderId: '567844538132',
    projectId: 'webtrit-voip-softphone',
    storageBucket: 'webtrit-voip-softphone.appspot.com',
    iosClientId: '567844538132-l2b2bhalkj8r85pn7ge2a9kq6f30uu7g.apps.googleusercontent.com',
    iosBundleId: 'com.webtrit.app',
  );
}
