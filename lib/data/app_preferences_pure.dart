import 'package:shared_preferences/shared_preferences.dart';

/// TODO: Rename this class to AppPreferences after migrating all usages from old AppPreferences
class AppPreferencesPure {
  AppPreferencesPure._(this._sharedPreferences);
  static late AppPreferencesPure _instance;
  factory AppPreferencesPure() => _instance;

  final SharedPreferences _sharedPreferences;

  static Future<AppPreferencesPure> init() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    _instance = AppPreferencesPure._(sharedPreferences);
    return _instance;
  }

  String? getString(String key) => _sharedPreferences.getString(key);
  Future<void> setString(String key, String value) => _sharedPreferences.setString(key, value);
  bool? getBool(String key) => _sharedPreferences.getBool(key);
  Future<void> setBool(String key, bool value) => _sharedPreferences.setBool(key, value);
  Future<void> remove(String key) => _sharedPreferences.remove(key);
}
