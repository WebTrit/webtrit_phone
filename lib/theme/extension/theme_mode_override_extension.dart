import 'package:webtrit_phone/theme/theme.dart';

import 'package:webtrit_phone/widgets/themed_scaffold.dart';

extension ThemeModeConfigExtension on ThemeModeConfig? {
  ContentThemeOverride toContentThemeOverride() {
    return switch (this) {
      ThemeModeConfig.light => ContentThemeOverride.light,
      ThemeModeConfig.dark => ContentThemeOverride.dark,
      ThemeModeConfig.system || null => ContentThemeOverride.auto,
    };
  }
}
