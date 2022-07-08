import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const _kRegisterStatusKey = 'register-status';

  static late AppPreferences _instance;

  static Future<void> init() async {
    _instance = AppPreferences._(await SharedPreferences.getInstance());
  }

  factory AppPreferences() {
    return _instance;
  }

  const AppPreferences._(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  Future<bool> clear() => _sharedPreferences.clear();

  bool getRegisterStatus() => _sharedPreferences.getBool(_kRegisterStatusKey) ?? true;

  Future<bool> setRegisterStatus(bool value) => _sharedPreferences.setBool(_kRegisterStatusKey, value);

  Future<bool> removeRegisterStatus() => _sharedPreferences.remove(_kRegisterStatusKey);
}
