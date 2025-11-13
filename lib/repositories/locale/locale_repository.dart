import 'package:flutter/material.dart';

import 'package:webtrit_phone/data/app_preferences_pure.dart';
import 'package:webtrit_phone/extensions/locale.dart';

abstract interface class LocaleRepository {
  Locale getLocale();

  Future<void> setLocale(Locale value);

  Future<void> clear();
}

class LocaleRepositoryPrefsImpl implements LocaleRepository {
  LocaleRepositoryPrefsImpl(this._appPreferences);

  final AppPreferencesPure _appPreferences;
  final _prefsKey = 'locale-language-tag';

  @override
  Locale getLocale() {
    final localeLanguageTag = _appPreferences.getString(_prefsKey);
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
  Future<void> setLocale(Locale value) => _appPreferences.setString(_prefsKey, value.toLanguageTag());

  @override
  Future<void> clear() => _appPreferences.remove(_prefsKey);
}
