import 'package:flutter/services.dart' as services;

import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/assets.gen.dart';

final Logger _logger = Logger('AppInfo');

class AppInfo {
  static late AppInfo _instance;

  static Future<AppInfo> init() async {
    final id = await FirebaseInstallations.instance.getId();

    String? appVersion = await getAppVersion();

    _instance = AppInfo._(id, appVersion);
    return _instance;
  }

  static Future<String?> getAppVersion() async {
    try {
      final pubspecString = await services.rootBundle.loadString(Assets.pubspec);
      final regExp = RegExp(r'app_version:\s*(\d+\.\d+\.\d+(\+\d+)?)');
      return regExp.firstMatch(pubspecString)?.group(1);
    } catch (e) {
      _logger.warning(e);
      return null;
    }
  }

  factory AppInfo() {
    return _instance;
  }

  AppInfo._(this._identifier, this._appVersion) {
    FirebaseInstallations.instance.onIdChange.listen((String id) {
      _identifier = id;
    });
  }

  String _identifier;

  String? _appVersion;

  String get identifier => _identifier;

  String get version => _appVersion ?? '';
}
