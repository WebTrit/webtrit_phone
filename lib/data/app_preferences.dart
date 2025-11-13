import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  AppPreferences._(this._sharedPreferences);
  static late AppPreferences _instance;
  factory AppPreferences() => _instance;

  final SharedPreferences _sharedPreferences;

  static Future<AppPreferences> init() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    _instance = AppPreferences._(sharedPreferences);
    return _instance;
  }

  String? getString(String key) => _sharedPreferences.getString(key);
  Future<void> setString(String key, String value) => _sharedPreferences.setString(key, value);
  bool? getBool(String key) => _sharedPreferences.getBool(key);
  Future<void> setBool(String key, bool value) => _sharedPreferences.setBool(key, value);
  Future<void> remove(String key) => _sharedPreferences.remove(key);
  List<String>? getStringList(String key) => _sharedPreferences.getStringList(key);
  Future<void> setStringList(String key, List<String> value) => _sharedPreferences.setStringList(key, value);
}
