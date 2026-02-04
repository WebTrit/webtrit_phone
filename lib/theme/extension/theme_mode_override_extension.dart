import 'package:webtrit_phone/theme/theme.dart';

import 'package:webtrit_phone/widgets/themed_scaffold.dart';

extension ThemeModeOverrideExtension on ThemeModeConfig? {
  ContentThemeOverride toContentThemeOverride() {
    return switch (this) {
      ThemeModeConfig.light => ContentThemeOverride.light,
      ThemeModeConfig.dark => ContentThemeOverride.dark,
      ThemeModeConfig.auto || null => ContentThemeOverride.auto,
    };
  }
}
