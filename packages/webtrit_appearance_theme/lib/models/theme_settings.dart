import 'package:freezed_annotation/freezed_annotation.dart';

import 'custom_color.dart';
import 'theme_page_config.dart';
import 'theme_widget_config.dart';

part 'theme_settings.freezed.dart';

part 'theme_settings.g.dart';

@freezed
class ThemeSettings with _$ThemeSettings {
  const factory ThemeSettings({
    required String seedColor,
    ColorSchemeOverride? lightColorSchemeOverride,
    ThemeWidgetConfig? themeWidgetLightConfig,
    ThemePageConfig? themePageLightConfig,
    ColorSchemeOverride? darkColorSchemeOverride,
    ThemeWidgetConfig? themeWidgetDarkConfig,
    ThemePageConfig? themePageDarkConfig,
    required List<CustomColor> primaryGradientColors,
    String? fontFamily,
    required String primaryOnboardingLogo,
    required String secondaryOnboardingLogo,
  }) = _ThemeSettings;

  factory ThemeSettings.fromJson(Map<String, dynamic> json) => _$ThemeSettingsFromJson(json);
}

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class ColorSchemeOverride with _$ColorSchemeOverride {
  const factory ColorSchemeOverride({
    String? primary,
    String? onPrimary,
    String? primaryContainer,
    String? onPrimaryContainer,
    String? primaryFixed,
    String? primaryFixedDim,
    String? onPrimaryFixed,
    String? onPrimaryFixedVariant,
    String? secondary,
    String? onSecondary,
    String? secondaryContainer,
    String? onSecondaryContainer,
    String? secondaryFixed,
    String? secondaryFixedDim,
    String? onSecondaryFixed,
    String? onSecondaryFixedVariant,
    String? tertiary,
    String? onTertiary,
    String? tertiaryContainer,
    String? onTertiaryContainer,
    String? tertiaryFixed,
    String? tertiaryFixedDim,
    String? onTertiaryFixed,
    String? onTertiaryFixedVariant,
    String? error,
    String? onError,
    String? errorContainer,
    String? onErrorContainer,
    String? outline,
    String? outlineVariant,
    String? surface,
    String? onSurface,
    String? surfaceDim,
    String? surfaceBright,
    String? surfaceContainerLowest,
    String? surfaceContainerLow,
    String? surfaceContainer,
    String? surfaceContainerHigh,
    String? surfaceContainerHighest,
    String? onSurfaceVariant,
    String? inverseSurface,
    String? onInverseSurface,
    String? inversePrimary,
    String? shadow,
    String? scrim,
    String? surfaceTint,
  }) = _ColorSchemeOverride;

  factory ColorSchemeOverride.fromJson(Map<String, dynamic> json) => _$ColorSchemeOverrideFromJson(json);
}
