import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:pub_semver/pub_semver.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';

class MockAppPreferencesService implements AppPreferences {
  MockAppPreferencesService({
    this.supportedFeatures = const [
      'autoProvision',
      'internalMessaging',
      'extensions',
      'signup',
      'userEvents',
      kSmsMessagingFeatureFlag,
      kChatMessagingFeatureFlag
    ],
  });

  final Map<String, dynamic> _mockData = {};
  final List<String> supportedFeatures;

  static MockAppPreferencesService create({List<String> features = const []}) {
    return MockAppPreferencesService(supportedFeatures: features);
  }

  @override
  Future<bool> clear({List<String> exclusion = const []}) async {
    final keysToRemove = _mockData.keys.where((key) => !exclusion.contains(key)).toList();
    for (final key in keysToRemove) {
      _mockData.remove(key);
    }
    return true;
  }

  @override
  bool getRegisterStatus() => true;

  @override
  Future<bool> setRegisterStatus(bool value) async {
    _mockData['register-status'] = value;
    return true;
  }

  @override
  Future<bool> removeRegisterStatus() async {
    _mockData.remove('register-status');
    return true;
  }

  @override
  ThemeMode getThemeMode() {
    final themeModeString = _mockData['theme-mode'] as String?;
    if (themeModeString != null) {
      try {
        return ThemeMode.values.byName(themeModeString);
      } catch (_) {
        return ThemeMode.system;
      }
    }
    return ThemeMode.system;
  }

  @override
  Future<bool> setThemeMode(ThemeMode value) async {
    _mockData['theme-mode'] = value.name;
    return true;
  }

  @override
  Future<bool> removeThemeMode() async {
    _mockData.remove('theme-mode');
    return true;
  }

  @override
  Locale getLocale() {
    final localeLanguageTag = _mockData['locale-language-tag'] as String?;
    if (localeLanguageTag != null) {
      try {
        return LocaleExtension.fromLanguageTag(localeLanguageTag);
      } catch (_) {
        return LocaleExtension.defaultNull;
      }
    }
    return LocaleExtension.defaultNull;
  }

  @override
  Future<bool> setLocale(Locale value) async {
    _mockData['locale-language-tag'] = value.toLanguageTag();
    return true;
  }

  @override
  Future<bool> removeLocale() async {
    _mockData.remove('locale-language-tag');
    return true;
  }

  @override
  MainFlavor getActiveMainFlavor({MainFlavor defaultValue = MainFlavor.contacts}) {
    final flavorString = _mockData['active-main-flavor'] as String?;
    if (flavorString != null) {
      try {
        return MainFlavor.values.byName(flavorString);
      } catch (_) {
        return defaultValue;
      }
    }
    return defaultValue;
  }

  @override
  Future<bool> setActiveMainFlavor(MainFlavor value) async {
    _mockData['active-main-flavor'] = value.name;
    return true;
  }

  @override
  RecentsVisibilityFilter getActiveRecentsVisibilityFilter(
      {RecentsVisibilityFilter defaultValue = RecentsVisibilityFilter.all}) {
    final filterString = _mockData['active-recents-visibility-filter'] as String?;
    if (filterString != null) {
      try {
        return RecentsVisibilityFilter.values.byName(filterString);
      } catch (_) {
        return defaultValue;
      }
    }
    return defaultValue;
  }

  @override
  Future<bool> setActiveRecentsVisibilityFilter(RecentsVisibilityFilter value) async {
    _mockData['active-recents-visibility-filter'] = value.name;
    return true;
  }

  @override
  ContactSourceType getActiveContactSourceType({ContactSourceType defaultValue = ContactSourceType.external}) {
    final sourceString = _mockData['active-contact-source-type'] as String?;
    if (sourceString != null) {
      try {
        return ContactSourceType.values.byName(sourceString);
      } catch (_) {
        return defaultValue;
      }
    }
    return defaultValue;
  }

  @override
  Future<bool> setActiveContactSourceType(ContactSourceType value) async {
    _mockData['active-contact-source-type'] = value.name;
    return true;
  }

  @override
  IncomingCallType getIncomingCallType({IncomingCallType defaultValue = IncomingCallType.pushNotification}) {
    final callTypeString = _mockData['call-incoming-type'] as String?;
    if (callTypeString != null) {
      try {
        return IncomingCallType.values.byName(callTypeString);
      } catch (_) {
        return defaultValue;
      }
    }
    return defaultValue;
  }

  @override
  Future<bool> setIncomingCallType(IncomingCallType value) async {
    _mockData['call-incoming-type'] = value.name;
    return true;
  }

  @override
  WebtritSystemInfo? getSystemInfo() {
    return WebtritSystemInfo(
      core: CoreInfo(version: Version(0, 13, 0)),
      postgres: PostgresInfo(version: '0.0'),
      adapter: AdapterInfo(
        name: 'Demo DB which hosts multiple tenants',
        version: '0.0.11',
        supported: supportedFeatures,
      ),
      janus: JanusInfo(
        version: '0.0.0',
        plugins: Plugins(sip: SipVersion(version: '0.0.0')),
        transports: Transports(websocket: Websocket(version: '0.0.0')),
      ),
      gorush: null,
    );
  }

  @override
  Future<void> setSystemInfo(WebtritSystemInfo systemInfo) async {}

  @override
  AgreementStatus getContactsAgreementStatus({
    AgreementStatus defaultValue = AgreementStatus.pending,
  }) {
    return AgreementStatus.pending;
  }

  @override
  AgreementStatus getUserAgreementStatus({
    AgreementStatus defaultValue = AgreementStatus.pending,
  }) {
    return AgreementStatus.pending;
  }

  @override
  Future<bool> setContactsAgreementStatus(AgreementStatus value) {
    return Future.value(true);
  }

  @override
  Future<bool> setUserAgreementStatus(AgreementStatus value) {
    return Future.value(true);
  }

  @override
  EncodingSettings getEncodingSettings() {
    return const EncodingSettings();
  }

  @override
  Future<void> setEncodingSettings(EncodingSettings settings) {
    return Future.value();
  }

  @override
  EncodingPreset? getEncodingPreset({EncodingPreset? defaultValue}) {
    return defaultValue;
  }

  @override
  Future<void> setEncodingPreset(EncodingPreset? value) {
    return Future.value();
  }

  @override
  AudioProcessingSettings getAudioProcessingSettings() {
    return const AudioProcessingSettings();
  }

  @override
  Future<void> setAudioProcessingSettings(AudioProcessingSettings settings) {
    return Future.value();
  }
}
