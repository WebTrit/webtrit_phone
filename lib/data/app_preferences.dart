import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:webtrit_phone/extensions/extensions.dart';

class AppPreferences {
  static const _kRegisterStatusKey = 'register-status';
  static const _kLocaleLanguageTagKey = 'locale-language-tag';

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

  Locale getLocale() {
    final localeLanguageTag = _sharedPreferences.getString(_kLocaleLanguageTagKey);
    if (localeLanguageTag != null) {
      try {
        return LocaleExtension.fromLanguageTag(localeLanguageTag);
      } catch (_) {
        return LocaleExtension.defaultNull;
      }
    } else {
      return LocaleExtension.defaultNull;
    }
  }

  Future<bool> setLocale(Locale value) => _sharedPreferences.setString(_kLocaleLanguageTagKey, value.toLanguageTag());

  Future<bool> removeLocale() => _sharedPreferences.remove(_kLocaleLanguageTagKey);
}
