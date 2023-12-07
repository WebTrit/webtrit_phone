import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  final Map<String, dynamic> map;

  static late DefaultFirebaseOptions _instance;

  static Future<DefaultFirebaseOptions> initialize(String path) async {
    final json = await rootBundle.loadString(path);
    _instance = DefaultFirebaseOptions._(jsonDecode(json));
    return _instance;
  }

  factory DefaultFirebaseOptions() {
    return _instance;
  }

  DefaultFirebaseOptions._(this.map);

  FirebaseOptions get currentPlatform {
    final platform = kIsWeb ? 'web' : defaultTargetPlatform.name;
    return FirebaseOptions(
      apiKey: map[platform]['apiKey'],
      appId: map[platform]['appId'],
      messagingSenderId: map[platform]['messagingSenderId'],
      projectId: map[platform]['projectId'],
      authDomain: map[platform]['authDomain'],
      storageBucket: map[platform]['storageBucket'],
      measurementId: map[platform]['measurementId'],
      iosClientId: map[platform]['iosClientId'],
      iosBundleId: map[platform]['iosBundleId'],
    );
  }
}
