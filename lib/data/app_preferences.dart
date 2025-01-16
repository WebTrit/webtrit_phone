import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/mappers/mappers.dart';

class AppPreferences with SystemInfoJsonMapper {
  static const _kRegisterStatusKey = 'register-status';
  static const _kThemeModeKey = 'theme-mode';
  static const _kLocaleLanguageTagKey = 'locale-language-tag';
  static const _kActiveMainFlavorKey = 'active-main-flavor';
  static const _kActiveRecentsVisibilityFilterKey = 'active-recents-visibility-filter';
  static const _kActiveContactSourceTypeKey = 'active-contact-source-type';
  static const _kUserAgreementAcceptedKey = 'user-agreement-accepted';
  static const _kContactsAgreementAcceptedKey = 'contacts-agreement-status';
  static const _kIncomingCallTypeKey = 'call-incoming-type';
  static const _kSystemInfoKey = 'system-info';
  static const _kPreferedAudioCodecKey = 'prefered-audio-codec';
  static const _kPreferedVideoCodecKey = 'prefered-video-codec';

  // Please add all new keys here for proper cleaning of preferences
  static const _kPreferencesList = [
    _kRegisterStatusKey,
    _kThemeModeKey,
    _kLocaleLanguageTagKey,
    _kActiveMainFlavorKey,
    _kActiveRecentsVisibilityFilterKey,
    _kActiveContactSourceTypeKey,
    _kUserAgreementAcceptedKey,
    _kContactsAgreementAcceptedKey,
    _kIncomingCallTypeKey,
    _kSystemInfoKey,
    _kPreferedAudioCodecKey,
    _kPreferedVideoCodecKey,
  ];

  // List of preferences keys to exclude by default during clean operation
  static const List<String> _defaultCleanExclusionList = [
    _kUserAgreementAcceptedKey,
    _kContactsAgreementAcceptedKey,
  ];

  static late AppPreferences _instance;

  static Future<AppPreferences> init() async {
    _instance = AppPreferences._(await SharedPreferences.getInstance());
    return _instance;
  }

  factory AppPreferences() {
    return _instance;
  }

  const AppPreferences._(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  Future<bool> clear({
    List<String> exclusion = _defaultCleanExclusionList,
  }) {
    return Future.wait(
      _kPreferencesList.where((key) => !exclusion.contains(key)).map((key) => _sharedPreferences.remove(key)).toList(),
    ).then(
      (results) => results.every((result) => result),
    );
  }

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

  MainFlavor getActiveMainFlavor({MainFlavor defaultValue = MainFlavor.contacts}) {
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

  Future<bool> setUserAgreementAccepted(bool value) => _sharedPreferences.setBool(_kUserAgreementAcceptedKey, value);

  bool getUserAgreementAccepted() => _sharedPreferences.getBool(_kUserAgreementAcceptedKey) ?? false;

  Future<bool> setContactsAgreementAccepted(AgreementStatus value) =>
      _sharedPreferences.setString(_kContactsAgreementAcceptedKey, value.name);

  AgreementStatus getContactsAgreementAccepted({AgreementStatus defaultValue = AgreementStatus.pending}) {
    final agreementStatusString = _sharedPreferences.getString(_kContactsAgreementAcceptedKey);
    if (agreementStatusString != null) {
      try {
        return AgreementStatus.values.byName(agreementStatusString);
      } catch (_) {
        return defaultValue;
      }
    } else {
      return defaultValue;
    }
  }

  Future<bool> setIncomingCallType(IncomingCallType value) =>
      _sharedPreferences.setString(_kIncomingCallTypeKey, value.name);

  IncomingCallType getIncomingCallType({
    IncomingCallType defaultValue = IncomingCallType.pushNotification,
  }) {
    final incomingCallType = _sharedPreferences.getString(_kIncomingCallTypeKey);
    if (incomingCallType != null) {
      try {
        return IncomingCallType.values.byName(incomingCallType);
      } catch (_) {
        return defaultValue;
      }
    } else {
      return defaultValue;
    }
  }

  Future<void> setSystemInfo(WebtritSystemInfo systemInfo) async {
    await _sharedPreferences.setString(_kSystemInfoKey, systemInfoToJson(systemInfo));
  }

  WebtritSystemInfo? getSystemInfo() {
    final systemInfoString = _sharedPreferences.getString(_kSystemInfoKey);
    if (systemInfoString != null) return systemInfoFromJson(systemInfoString);
    return null;
  }

  Future<void> setPreferedAudioCodec(AudioCodec? value) {
    if (value != null) {
      return _sharedPreferences.setString(_kPreferedAudioCodecKey, value.name);
    } else {
      return _sharedPreferences.remove(_kPreferedAudioCodecKey);
    }
  }

  AudioCodec? getPreferedAudioCodec() {
    final preferedAudioCodec = _sharedPreferences.getString(_kPreferedAudioCodecKey);
    if (preferedAudioCodec == null) return null;
    return AudioCodec.values.byName(preferedAudioCodec);
  }

  Future<void> setPreferedVideoCodec(VideoCodec? value) {
    if (value != null) {
      return _sharedPreferences.setString(_kPreferedVideoCodecKey, value.name);
    } else {
      return _sharedPreferences.remove(_kPreferedVideoCodecKey);
    }
  }

  VideoCodec? getPreferedVideoCodec() {
    final preferedVideoCodec = _sharedPreferences.getString(_kPreferedVideoCodecKey);
    if (preferedVideoCodec == null) return null;
    return VideoCodec.values.byName(preferedVideoCodec);
  }
}
