import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

extension ThemeModeL10n on ThemeMode {
  String l10n(BuildContext context) {
    switch (this) {
      case ThemeMode.system:
        return context.l10n.themeMode_system;
      case ThemeMode.light:
        return context.l10n.themeMode_light;
      case ThemeMode.dark:
        return context.l10n.themeMode_dark;
    }
  }
}
