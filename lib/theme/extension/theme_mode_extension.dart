import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

extension ThemeModeConfigExtension on ThemeModeConfig? {
  ThemeMode toContentThemeOverride() {
    return switch (this) {
      ThemeModeConfig.light => ThemeMode.light,
      ThemeModeConfig.dark => ThemeMode.dark,
      ThemeModeConfig.system || null => ThemeMode.system,
    };
  }
}
