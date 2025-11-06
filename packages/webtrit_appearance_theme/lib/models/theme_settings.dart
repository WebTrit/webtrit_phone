import 'package:freezed_annotation/freezed_annotation.dart';

import 'color_scheme.config.dart';
import 'theme_page_config.dart';
import 'theme_widget_config.dart';

part 'theme_settings.freezed.dart';

part 'theme_settings.g.dart';

@freezed
@JsonSerializable(explicitToJson: true)
class ThemeSettings with _$ThemeSettings {
  /// Creates a [ThemeSettings] configuration that defines
  /// light/dark color schemes, widget styles, and page-level theming.
  const ThemeSettings({
    // Colors scheme
    this.lightColorSchemeConfig = const ColorSchemeConfig(),
    this.darkColorSchemeConfig = const ColorSchemeConfig(),

    // Widgets config
    this.themeWidgetLightConfig = const ThemeWidgetConfig(),
    this.themeWidgetDarkConfig = const ThemeWidgetConfig(),

    // Pages config
    this.themePageLightConfig = const ThemePageConfig(),
    this.themePageDarkConfig = const ThemePageConfig(),
  });

  /// Configuration for the light color scheme.
  @override
  final ColorSchemeConfig lightColorSchemeConfig;

  /// Configuration for the dark color scheme.
  @override
  final ColorSchemeConfig darkColorSchemeConfig;

  /// Widget-level configuration for the light theme.
  @override
  final ThemeWidgetConfig themeWidgetLightConfig;

  /// Widget-level configuration for the dark theme.
  @override
  final ThemeWidgetConfig themeWidgetDarkConfig;

  /// Page-level configuration for the light theme.
  @override
  final ThemePageConfig themePageLightConfig;

  /// Page-level configuration for the dark theme.
  @override
  final ThemePageConfig themePageDarkConfig;

  factory ThemeSettings.fromJson(Map<String, Object?> json) => _$ThemeSettingsFromJson(json);

  Map<String, Object?> toJson() => _$ThemeSettingsToJson(this);
}
