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
    Color? primaryFixed,
    Color? primaryFixedDim,
    Color? onPrimaryFixed,
    Color? onPrimaryFixedVariant,
    Color? secondary,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? secondaryFixed,
    Color? secondaryFixedDim,
    Color? onSecondaryFixed,
    Color? onSecondaryFixedVariant,
    Color? tertiary,
    Color? onTertiary,
    Color? tertiaryContainer,
    Color? onTertiaryContainer,
    Color? tertiaryFixed,
    Color? tertiaryFixedDim,
    Color? onTertiaryFixed,
    Color? onTertiaryFixedVariant,
    Color? error,
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    Color? outline,
    Color? outlineVariant,
    Color? surface,
    Color? onSurface,
    Color? surfaceDim,
    Color? surfaceBright,
    Color? surfaceContainerLowest,
    Color? surfaceContainerLow,
    Color? surfaceContainer,
    Color? surfaceContainerHigh,
    Color? surfaceContainerHighest,
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
