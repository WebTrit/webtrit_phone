import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/main/models/models.dart';
import 'package:webtrit_phone/models/models.dart';

class AppPreferences {
  static const _kRegisterStatusKey = 'register-status';
  static const _kThemeModeKey = 'theme-mode';
  static const _kLocaleLanguageTagKey = 'locale-language-tag';
  static const _kActiveMainFlavorKey = 'active-main-flavor';
  static const _kActiveRecentsVisibilityFilterKey = 'active-recents-visibility-filter';
  static const _kActiveContactSourceTypeKey = 'active-contact-source-type';
  static const _kUserAgreement = 'user-agreement';

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

  ThemeMode getThemeMode() {
    final themeModeString = _sharedPreferences.getString(_kThemeModeKey);
    if (themeModeString != null) {
      try {
        return ThemeMode.values.byName(themeModeString);
      } catch (_) {
        return ThemeMode.system;
      }
    } else {
      return ThemeMode.system;
    }
  }

  Future<bool> setThemeMode(ThemeMode value) => _sharedPreferences.setString(_kThemeModeKey, value.name);

  Future<bool> removeThemeMode() => _sharedPreferences.remove(_kThemeModeKey);

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

  MainFlavor getActiveMainFlavor({MainFlavor defaultValue = MainFlavor.keypad}) {
    final activeMainFlavorString = _sharedPreferences.getString(_kActiveMainFlavorKey);
    if (activeMainFlavorString != null) {
      try {
        return MainFlavor.values.byName(activeMainFlavorString);
      } catch (_) {
        return defaultValue;
      }
    } else {
      return defaultValue;
    }
  }

  Future<bool> setActiveMainFlavor(MainFlavor value) => _sharedPreferences.setString(_kActiveMainFlavorKey, value.name);

  RecentsVisibilityFilter getActiveRecentsVisibilityFilter(
      {RecentsVisibilityFilter defaultValue = RecentsVisibilityFilter.all}) {
    final activeRecentsVisibilityFilterString = _sharedPreferences.getString(_kActiveRecentsVisibilityFilterKey);
    if (activeRecentsVisibilityFilterString != null) {
      try {
        return RecentsVisibilityFilter.values.byName(activeRecentsVisibilityFilterString);
      } catch (_) {
        return defaultValue;
      }
    } else {
      return defaultValue;
    }
  }

  Future<bool> setActiveRecentsVisibilityFilter(RecentsVisibilityFilter value) =>
      _sharedPreferences.setString(_kActiveRecentsVisibilityFilterKey, value.name);

  ContactSourceType getActiveContactSourceType({ContactSourceType defaultValue = ContactSourceType.external}) {
    final activeContactSourceTypeString = _sharedPreferences.getString(_kActiveContactSourceTypeKey);
    if (activeContactSourceTypeString != null) {
      try {
        return ContactSourceType.values.byName(activeContactSourceTypeString);
      } catch (_) {
        return defaultValue;
      }
    } else {
      return defaultValue;
    }
  }

  Future<bool> setActiveContactSourceType(ContactSourceType value) =>
      _sharedPreferences.setString(_kActiveContactSourceTypeKey, value.name);

  Future<bool> setUserAgreement(bool value) => _sharedPreferences.setBool(_kUserAgreement, value);

  bool getUserAgreement() => _sharedPreferences.getBool(_kUserAgreement) ?? false;
}
