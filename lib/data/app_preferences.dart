import 'package:shared_preferences/shared_preferences.dart';

abstract class AppPreferences {
  String? getString(String key);

  Future<void> setString(String key, String value);

  bool? getBool(String key);

  Future<void> setBool(String key, bool value);

  List<String>? getStringList(String key);

  Future<void> setStringList(String key, List<String> value);

  Future<void> remove(String key);
}

class AppPreferencesImpl implements AppPreferences {
  static AppPreferencesImpl? _instance;

  final SharedPreferences _sharedPreferences;

  AppPreferencesImpl._(this._sharedPreferences);

  factory AppPreferencesImpl() {
    if (_instance == null) {
      throw Exception('AppPreferencesImpl.init() must be called before accessing the instance.');
    }
    return _instance!;
  }

  static Future<AppPreferences> init() async {
    if (_instance != null) {
      return _instance!;
    }

    final sharedPreferences = await SharedPreferences.getInstance();
    _instance = AppPreferencesImpl._(sharedPreferences);
    return _instance!;
  }

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
