import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/mappers/mappers.dart';

abstract class AppPreferences {
  Future<bool> clear({List<String> exclusion});

  bool getRegisterStatus();

  Future<bool> setRegisterStatus(bool value);

  Future<bool> removeRegisterStatus();

  ThemeMode getThemeMode();

  Future<bool> setThemeMode(ThemeMode value);

  Future<bool> removeThemeMode();

  Locale getLocale();

  Future<bool> setLocale(Locale value);

  Future<bool> removeLocale();

  MainFlavor getActiveMainFlavor({MainFlavor defaultValue});

  Future<bool> setActiveMainFlavor(MainFlavor value);

  RecentsVisibilityFilter getActiveRecentsVisibilityFilter({RecentsVisibilityFilter defaultValue});

  Future<bool> setActiveRecentsVisibilityFilter(RecentsVisibilityFilter value);

  ContactSourceType getActiveContactSourceType({ContactSourceType defaultValue});

  Future<bool> setActiveContactSourceType(ContactSourceType value);

  Future<bool> setUserAgreementStatus(AgreementStatus value);

  AgreementStatus getUserAgreementStatus({AgreementStatus defaultValue = AgreementStatus.pending});

  Future<bool> setContactsAgreementStatus(AgreementStatus value);

  AgreementStatus getContactsAgreementStatus({AgreementStatus defaultValue = AgreementStatus.pending});

  IncomingCallType getIncomingCallType({IncomingCallType defaultValue});

  Future<bool> setIncomingCallType(IncomingCallType value);

  WebtritSystemInfo? getSystemInfo();

  Future<void> setSystemInfo(WebtritSystemInfo systemInfo);

  AudioCodec? getPreferedAudioCodec();

  Future<void> setPreferedAudioCodec(AudioCodec? value);

  VideoCodec? getPreferedVideoCodec();

  Future<void> setPreferedVideoCodec(VideoCodec? value);
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

class AppPreferencesImpl with SystemInfoJsonMapper implements AppPreferences {
  static const _kRegisterStatusKey = 'register-status';
  static const _kThemeModeKey = 'theme-mode';
  static const _kLocaleLanguageTagKey = 'locale-language-tag';
  static const _kActiveMainFlavorKey = 'active-main-flavor';
  static const _kActiveRecentsVisibilityFilterKey = 'active-recents-visibility-filter';
  static const _kActiveContactSourceTypeKey = 'active-contact-source-type';
  static const _kUserAgreementAcceptedKey = 'user-agreement-status';
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

  final SharedPreferences _sharedPreferences;

  AppPreferencesImpl(this._sharedPreferences);

  @override
  Future<bool> clear({
    List<String> exclusion = _defaultCleanExclusionList,
  }) {
    return Future.wait(
      _kPreferencesList.where((key) => !exclusion.contains(key)).map((key) => _sharedPreferences.remove(key)).toList(),
    ).then(
      (results) => results.every((result) => result),
    );
  }

  @override
  bool getRegisterStatus() => _sharedPreferences.getBool(_kRegisterStatusKey) ?? true;

  @override
  Future<bool> setRegisterStatus(bool value) => _sharedPreferences.setBool(_kRegisterStatusKey, value);

  @override
  Future<bool> removeRegisterStatus() => _sharedPreferences.remove(_kRegisterStatusKey);

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

  @override
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

  @override
  Future<bool> setActiveMainFlavor(MainFlavor value) => _sharedPreferences.setString(_kActiveMainFlavorKey, value.name);

  @override
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

  @override
  Future<bool> setActiveRecentsVisibilityFilter(RecentsVisibilityFilter value) =>
      _sharedPreferences.setString(_kActiveRecentsVisibilityFilterKey, value.name);

  @override
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

  @override
  Future<bool> setActiveContactSourceType(ContactSourceType value) =>
      _sharedPreferences.setString(_kActiveContactSourceTypeKey, value.name);

  @override
  Future<bool> setUserAgreementStatus(AgreementStatus value) =>
      _sharedPreferences.setString(_kUserAgreementAcceptedKey, value.name);

  @override
  AgreementStatus getUserAgreementStatus({AgreementStatus defaultValue = AgreementStatus.pending}) {
    final agreementStatusString = _sharedPreferences.getString(_kUserAgreementAcceptedKey);
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

  @override
  Future<bool> setContactsAgreementStatus(AgreementStatus value) =>
      _sharedPreferences.setString(_kContactsAgreementAcceptedKey, value.name);

  @override
  AgreementStatus getContactsAgreementStatus({AgreementStatus defaultValue = AgreementStatus.pending}) {
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

  @override
  Future<bool> setIncomingCallType(IncomingCallType value) =>
      _sharedPreferences.setString(_kIncomingCallTypeKey, value.name);

  @override
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

  @override
  Future<void> setSystemInfo(WebtritSystemInfo systemInfo) async {
    await _sharedPreferences.setString(_kSystemInfoKey, systemInfoToJson(systemInfo));
  }

  @override
  WebtritSystemInfo? getSystemInfo() {
    final systemInfoString = _sharedPreferences.getString(_kSystemInfoKey);
    if (systemInfoString != null) return systemInfoFromJson(systemInfoString);
    return null;
  }

  @override
  Future<void> setPreferedAudioCodec(AudioCodec? value) {
    if (value != null) {
      return _sharedPreferences.setString(_kPreferedAudioCodecKey, value.name);
    } else {
      return _sharedPreferences.remove(_kPreferedAudioCodecKey);
    }
  }

  @override
  AudioCodec? getPreferedAudioCodec() {
    final preferedAudioCodec = _sharedPreferences.getString(_kPreferedAudioCodecKey);
    if (preferedAudioCodec == null) return null;
    return AudioCodec.values.byName(preferedAudioCodec);
  }

  @override
  Future<void> setPreferedVideoCodec(VideoCodec? value) {
    if (value != null) {
      return _sharedPreferences.setString(_kPreferedVideoCodecKey, value.name);
    } else {
      return _sharedPreferences.remove(_kPreferedVideoCodecKey);
    }
  }

  @override
  VideoCodec? getPreferedVideoCodec() {
    final preferedVideoCodec = _sharedPreferences.getString(_kPreferedVideoCodecKey);
    if (preferedVideoCodec == null) return null;
    return VideoCodec.values.byName(preferedVideoCodec);
  }
}
