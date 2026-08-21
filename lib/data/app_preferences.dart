import 'package:shared_preferences/shared_preferences.dart';

abstract class AppPreferences {
  String? getSystemInfo();

  Future<void> setSystemInfo(String value);

  String? getFcmPushToken();

  Future<void> setFcmPushToken(String value);

  String? getString(String key);

  Future<void> setString(String key, String value);

  bool? getBool(String key);

  Future<void> setBool(String key, bool value);

  List<String>? getStringList(String key);

  Future<void> setStringList(String key, List<String> value);

  Future<void> remove(String key);
}

class AppPreferencesImpl implements AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferencesImpl._(this._sharedPreferences);

  static Future<AppPreferences> init() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return AppPreferencesImpl._(sharedPreferences);
  }

  static const _systemInfoKey = 'system-info';
  static const _fcmPushTokenKey = 'fcm-push-token';

  @override
  String? getSystemInfo() => getString(_systemInfoKey);

  @override
  Future<void> setSystemInfo(String value) => setString(_systemInfoKey, value);

  @override
  String? getFcmPushToken() => getString(_fcmPushTokenKey);

  @override
  Future<void> setFcmPushToken(String value) => setString(_fcmPushTokenKey, value);

  @override
  String? getString(String key) => _sharedPreferences.getString(key);

  @override
  Future<void> setString(String key, String value) => _sharedPreferences.setString(key, value);

  @override
  bool? getBool(String key) => _sharedPreferences.getBool(key);

  @override
  Future<void> setBool(String key, bool value) => _sharedPreferences.setBool(key, value);

  @override
  List<String>? getStringList(String key) => _sharedPreferences.getStringList(key);

  @override
  Future<void> setStringList(String key, List<String> value) => _sharedPreferences.setStringList(key, value);

  @override
  Future<void> remove(String key) => _sharedPreferences.remove(key);
}
