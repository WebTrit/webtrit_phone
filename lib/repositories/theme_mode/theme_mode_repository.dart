import 'package:flutter/material.dart';

import 'package:webtrit_phone/data/app_preferences_pure.dart';

abstract interface class ThemeModeRepository {
  ThemeMode getThemeMode();

  Future<void> setThemeMode(ThemeMode value);

  Future<void> clear();
}

class ThemeModeRepositoryPrefsImpl implements ThemeModeRepository {
  ThemeModeRepositoryPrefsImpl(this._appPreferences);

  final AppPreferencesPure _appPreferences;
  final _prefsKey = 'theme-mode';

  @override
  ThemeMode getThemeMode() {
    final themeModeString = _appPreferences.getString(_prefsKey);
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
  Future<void> setThemeMode(ThemeMode value) => _appPreferences.setString(_prefsKey, value.name);

  @override
  Future<void> clear() => _appPreferences.remove(_prefsKey);
}
