import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_config.dart';
import 'color_scheme.config.dart';
import 'theme_page_config.dart';
import 'theme_widget_config.dart';

part 'theme_settings.freezed.dart';

part 'theme_settings.g.dart';

@freezed
class ThemeSettings with _$ThemeSettings {
  const factory ThemeSettings({
    // Colors scheme
    @Default(ColorSchemeConfig()) ColorSchemeConfig lightColorSchemeConfig,
    @Default(ColorSchemeConfig()) ColorSchemeConfig darkColorSchemeConfig,
    // Widgets config
    @Default(ThemeWidgetConfig()) ThemeWidgetConfig themeWidgetLightConfig,
    @Default(ThemeWidgetConfig()) ThemeWidgetConfig themeWidgetDarkConfig,
    // Pages config
    @Default(ThemePageConfig()) ThemePageConfig themePageLightConfig,
    @Default(ThemePageConfig()) ThemePageConfig themePageDarkConfig,
    // Feature access
    AppConfig? appConfig,
  }) = _ThemeSettings;

  factory ThemeSettings.fromJson(Map<String, dynamic> json) => _$ThemeSettingsFromJson(json);
}
