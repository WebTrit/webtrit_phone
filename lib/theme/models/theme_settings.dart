import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'theme_asset.dart';
import 'theme_json_serializable.dart';
import 'custom_color.dart';
import 'theme_page_config.dart';
import 'theme_widget_config.dart';

part 'theme_settings.freezed.dart';

part 'theme_settings.g.dart';

@freezed
class ThemeSettings with _$ThemeSettings {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory ThemeSettings({
    required Color seedColor,
    ColorSchemeOverride? lightColorSchemeOverride,
    ThemeWidgetConfig? themeWidgetLightConfig,
    ThemePageConfig? themePageLightConfig,
    ColorSchemeOverride? darkColorSchemeOverride,
    ThemeWidgetConfig? themeWidgetDarkConfig,
    ThemePageConfig? themePageDarkConfig,
    required List<CustomColor> primaryGradientColors,
    String? fontFamily,
    required ThemeSvgAsset primaryOnboardingLogo,
    required ThemeSvgAsset secondaryOnboardingLogo,
  }) = _ThemeSettings;

  factory ThemeSettings.fromJson(Map<String, dynamic> json) => _$ThemeSettingsFromJson(json);
}

@freezed
class ColorSchemeOverride with _$ColorSchemeOverride {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory ColorSchemeOverride({
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? secondary,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? tertiary,
    Color? onTertiary,
    Color? tertiaryContainer,
    Color? onTertiaryContainer,
    Color? error,
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    Color? outline,
    Color? outlineVariant,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? onSurface,
    Color? surfaceVariant,
    Color? onSurfaceVariant,
    Color? inverseSurface,
    Color? onInverseSurface,
    Color? inversePrimary,
    Color? shadow,
    Color? scrim,
    Color? surfaceTint,
  }) = _ColorSchemeOverride;

  factory ColorSchemeOverride.fromJson(Map<String, dynamic> json) => _$ColorSchemeOverrideFromJson(json);
}
