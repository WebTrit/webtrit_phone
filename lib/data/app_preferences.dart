import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/mappers/mappers.dart';

abstract class AppPreferences {
  Future<bool> clear({List<String> exclusion});

  ThemeMode getThemeMode();

  Future<bool> setThemeMode(ThemeMode value);

  Future<bool> removeThemeMode();

  Locale getLocale();

  Future<bool> setLocale(Locale value);

  Future<bool> removeLocale();

  Future<bool> setContactsAgreementStatus(AgreementStatus value);

  AgreementStatus getContactsAgreementStatus({AgreementStatus defaultValue = AgreementStatus.pending});

  IncomingCallType getIncomingCallType({IncomingCallType defaultValue});

  Future<bool> setIncomingCallType(IncomingCallType value);

  EncodingSettings getEncodingSettings();

  Future<void> setEncodingSettings(EncodingSettings settings);

  EncodingPreset? getEncodingPreset({EncodingPreset? defaultValue});

  Future<void> setEncodingPreset(EncodingPreset? value);

  AudioProcessingSettings getAudioProcessingSettings();

  Future<void> setAudioProcessingSettings(AudioProcessingSettings settings);

  VideoCapturingSettings getVideoCapturingSettings();

  Future<void> setVideoCapturingSettings(VideoCapturingSettings settings);

  IceSettings getIceSettings();

  Future<void> setIceSettings(IceSettings settings);

  PeerConnectionSettings getPeerConnectionSettings({PeerConnectionSettings? defaultValue});

  Future<void> setPearConnectionSettings(PeerConnectionSettings settings);
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
  IncomingCallType getIncomingCallType({IncomingCallType defaultValue = IncomingCallType.pushNotification}) {
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
  EncodingSettings getEncodingSettings() {
    final encodingSettingsString = _sharedPreferences.getString(_kEncodingSettingsKey);
    if (encodingSettingsString != null) {
      return encodingSettingsFromJson(encodingSettingsString);
    } else {
      return EncodingSettings.blank();
    }
  }

  @override
  Future<void> setEncodingSettings(EncodingSettings settings) {
    return _sharedPreferences.setString(_kEncodingSettingsKey, encodingSettingsToJson(settings));
  }

  @override
  EncodingPreset? getEncodingPreset({EncodingPreset? defaultValue}) {
    final encodingPresetString = _sharedPreferences.getString(_kEncodingPresetKey);
    if (encodingPresetString != null) {
      return EncodingPreset.values.byName(encodingPresetString);
    } else {
      return defaultValue;
    }
  }

  @override
  Future<void> setEncodingPreset(EncodingPreset? value) {
    if (value != null) {
      return _sharedPreferences.setString(_kEncodingPresetKey, value.name);
    } else {
      return _sharedPreferences.remove(_kEncodingPresetKey);
    }
  }

  @override
  AudioProcessingSettings getAudioProcessingSettings() {
    final audioProcessingSettingsString = _sharedPreferences.getString(_kAudioProcessingSettingsKey);
    if (audioProcessingSettingsString != null) {
      return audioProcessingSettingsFromJson(audioProcessingSettingsString);
    } else {
      return AudioProcessingSettings.blank();
    }
  }

  @override
  Future<void> setAudioProcessingSettings(AudioProcessingSettings settings) {
    return _sharedPreferences.setString(_kAudioProcessingSettingsKey, audioProcessingSettingsToJson(settings));
  }

  @override
  VideoCapturingSettings getVideoCapturingSettings() {
    final videoCapturingSettingsString = _sharedPreferences.getString(_kVideoCapturingSettingsKey);
    if (videoCapturingSettingsString != null) {
      return videoCapturingSettingsFromJson(videoCapturingSettingsString);
    } else {
      return VideoCapturingSettings.blank();
    }
  }

  @override
  Future<void> setVideoCapturingSettings(VideoCapturingSettings settings) {
    return _sharedPreferences.setString(_kVideoCapturingSettingsKey, videoCapturingSettingsToJson(settings));
  }

  @override
  IceSettings getIceSettings() {
    final iceSettingsString = _sharedPreferences.getString(_kIceSettingsKey);
    if (iceSettingsString != null) {
      return iceSettingsFromJson(iceSettingsString);
    } else {
      return IceSettings.blank();
    }
  }

  @override
  Future<void> setIceSettings(IceSettings settings) {
    return _sharedPreferences.setString(_kIceSettingsKey, iceSettingsToJson(settings));
  }

  @override
  PeerConnectionSettings getPeerConnectionSettings({PeerConnectionSettings? defaultValue}) {
    final defaultPeerConnectionSettings = defaultValue ?? PeerConnectionSettings.blank();
    final localNegotiationSettings = _getNegotiationSettings();

    return defaultPeerConnectionSettings.copyWith(
      negotiationSettings: defaultPeerConnectionSettings.negotiationSettings.copyWith(
        includeInactiveVideoInOfferAnswer: localNegotiationSettings?.includeInactiveVideoInOfferAnswer,
      ),
    );
  }

  NegotiationSettings? _getNegotiationSettings() {
    final negotiationSettingsString = _sharedPreferences.getString(_kNegotiationSettings);
    if (negotiationSettingsString != null) {
      return negotiationSettingsFromJson(negotiationSettingsString);
    } else {
      return null;
    }
  }

  @override
  Future<void> setPearConnectionSettings(PeerConnectionSettings settings) async {
    await _setNegotiationSettings(settings.negotiationSettings);
  }

  Future<void> _setNegotiationSettings(NegotiationSettings settings) {
    return _sharedPreferences.setString(_kNegotiationSettings, negotiationSettingsToJson(settings));
  }
}
