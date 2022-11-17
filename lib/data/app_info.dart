import 'package:firebase_app_installations/firebase_app_installations.dart';

class AppInfo {
  static late AppInfo _instance;

  static Future<void> init() async {
    final id = await FirebaseInstallations.instance.getId();
    _instance = AppInfo._(id);
  }

  factory AppInfo() {
    return _instance;
  }

  AppInfo._(this._identifier) {
    FirebaseInstallations.instance.onIdChange.listen((String id) {
      _identifier = id;
    });
  }

  String _identifier;

  String get identifier => _identifier;
}
