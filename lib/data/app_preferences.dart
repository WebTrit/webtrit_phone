import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/mappers/mappers.dart';

abstract class AppPreferences {
  Future<bool> clear({List<String> exclusion});

  ThemeMode getThemeMode();

  Future<bool> setThemeMode(ThemeMode value);

  Future<bool> removeThemeMode();

  Locale getLocale();

  Future<bool> setLocale(Locale value);

  Future<bool> removeLocale();
}

class AppPreferencesFactory {
  static late AppPreferences _instance;

  static Future<AppPreferences> init() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    _instance = AppPreferencesImpl(sharedPreferences);
    return _instance;
  }

  static AppPreferences get instance => _instance;
}

class AppPreferencesImpl
    with
        SystemInfoJsonMapper,
        EncodingSettingsJsonMapper,
        AudioProcessingSettingsJsonMapper,
        VideoCapturingSettingsJsonMapper,
        IceSettingsJsonMapper,
        NegotiationSettingsJsonMapper,
        CallerIdSettingsJsonMapper
    implements AppPreferences {
  static const _kThemeModeKey = 'theme-mode';
  static const _kLocaleLanguageTagKey = 'locale-language-tag';
  static const _kActiveRecentsVisibilityFilterKey = 'active-recents-visibility-filter';
  static const _kActiveContactSourceTypeKey = 'active-contact-source-type';
  static const _kUserAgreementAcceptedKey = 'user-agreement-status';
  static const _kContactsAgreementAcceptedKey = 'contacts-agreement-status';
  static const _kIncomingCallTypeKey = 'call-incoming-type';
  static const _kEncodingSettingsKey = 'encoding-settings';
  static const _kEncodingPresetKey = 'encoding-preset';
  static const _kAudioProcessingSettingsKey = 'audio-processing-settings';
  static const _kVideoCapturingSettingsKey = 'video-capturing-settings';
  static const _kIceSettingsKey = 'ice-settings';
  static const _kNegotiationSettings = 'negotiation-settings';
  static const _kCallerIdSettingsKey = 'caller-id-settings';

  // Please add all new keys here for proper cleaning of preferences
  static const _kPreferencesList = [
    _kThemeModeKey,
    _kLocaleLanguageTagKey,
    _kActiveRecentsVisibilityFilterKey,
    _kActiveContactSourceTypeKey,
    _kUserAgreementAcceptedKey,
    _kContactsAgreementAcceptedKey,
    _kIncomingCallTypeKey,
    _kEncodingSettingsKey,
    _kEncodingPresetKey,
    _kAudioProcessingSettingsKey,
    _kVideoCapturingSettingsKey,
    _kIceSettingsKey,
    _kCallerIdSettingsKey,
  ];

  // List of preferences keys to exclude by default during clean operation
  static const List<String> _defaultCleanExclusionList = [_kUserAgreementAcceptedKey, _kContactsAgreementAcceptedKey];

  final SharedPreferences _sharedPreferences;

  AppPreferencesImpl(this._sharedPreferences);

  @override
  Future<bool> clear({List<String> exclusion = _defaultCleanExclusionList}) {
    return Future.wait(
      _kPreferencesList.where((key) => !exclusion.contains(key)).map((key) => _sharedPreferences.remove(key)).toList(),
    ).then((results) => results.every((result) => result));
  }

  @override
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

  @override
  Future<bool> setThemeMode(ThemeMode value) => _sharedPreferences.setString(_kThemeModeKey, value.name);

  @override
  Future<bool> removeThemeMode() => _sharedPreferences.remove(_kThemeModeKey);

  @override
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

  @override
  Future<bool> setLocale(Locale value) => _sharedPreferences.setString(_kLocaleLanguageTagKey, value.toLanguageTag());

  @override
  Future<bool> removeLocale() => _sharedPreferences.remove(_kLocaleLanguageTagKey);
}
