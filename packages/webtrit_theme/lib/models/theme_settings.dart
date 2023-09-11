import 'package:freezed_annotation/freezed_annotation.dart';

import 'custom_color.dart';

part 'theme_settings.freezed.dart';

part 'theme_settings.g.dart';

@freezed
class ThemeSettings with _$ThemeSettings {
  // ignore: invalid_annotation_target
  const factory ThemeSettings({
    required String seedColor,
    ColorSchemeOverride? lightColorSchemeOverride,
    ColorSchemeOverride? darkColorSchemeOverride,
    required List<CustomColor> primaryGradientColors,
    String? fontFamily,
    required String primaryOnboardingLogo,
    required String secondaryOnboardingLogo,
  }) = _ThemeSettings;

  factory ThemeSettings.fromJson(Map<String, dynamic> json) => _$ThemeSettingsFromJson(json);
}

@freezed
class ColorSchemeOverride with _$ColorSchemeOverride {
  // ignore: invalid_annotation_target
  const factory ColorSchemeOverride({
    String? primary,
    String? onPrimary,
    String? primaryContainer,
    String? onPrimaryContainer,
    String? secondary,
    String? onSecondary,
    String? secondaryContainer,
    String? onSecondaryContainer,
    String? tertiary,
    String? onTertiary,
    String? tertiaryContainer,
    String? onTertiaryContainer,
    String? error,
    String? onError,
    String? errorContainer,
    String? onErrorContainer,
    String? outline,
    String? outlineVariant,
    String? background,
    String? onBackground,
    String? surface,
    String? onSurface,
    String? surfaceVariant,
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
