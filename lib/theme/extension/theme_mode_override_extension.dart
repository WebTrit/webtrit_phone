import 'package:webtrit_appearance_theme/models/theme_page_config.dart';
import 'package:webtrit_phone/widgets/themed_scaffold.dart';

extension ThemeModeOverrideExtension on ThemeModeOverride? {
  ContentThemeOverride toContentThemeOverride() {
    return switch (this) {
      ThemeModeOverride.light => ContentThemeOverride.light,
      ThemeModeOverride.dark => ContentThemeOverride.dark,
      ThemeModeOverride.auto || null => ContentThemeOverride.auto,
    };
  }
}
