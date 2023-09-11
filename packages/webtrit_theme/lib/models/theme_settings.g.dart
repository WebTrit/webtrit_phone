// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ThemeSettings _$$_ThemeSettingsFromJson(Map<String, dynamic> json) =>
    _$_ThemeSettings(
      seedColor: json['seedColor'] as String,
      lightColorSchemeOverride: json['lightColorSchemeOverride'] == null
          ? null
          : ColorSchemeOverride.fromJson(
              json['lightColorSchemeOverride'] as Map<String, dynamic>),
      darkColorSchemeOverride: json['darkColorSchemeOverride'] == null
          ? null
          : ColorSchemeOverride.fromJson(
              json['darkColorSchemeOverride'] as Map<String, dynamic>),
      primaryGradientColors: (json['primaryGradientColors'] as List<dynamic>)
          .map((e) => CustomColor.fromJson(e as Map<String, dynamic>))
          .toList(),
      fontFamily: json['fontFamily'] as String?,
      primaryOnboardingLogo: json['primaryOnboardingLogo'] as String,
      secondaryOnboardingLogo: json['secondaryOnboardingLogo'] as String,
    );

Map<String, dynamic> _$$_ThemeSettingsToJson(_$_ThemeSettings instance) =>
    <String, dynamic>{
      'seedColor': instance.seedColor,
      'lightColorSchemeOverride': instance.lightColorSchemeOverride,
      'darkColorSchemeOverride': instance.darkColorSchemeOverride,
      'primaryGradientColors': instance.primaryGradientColors,
      'fontFamily': instance.fontFamily,
      'primaryOnboardingLogo': instance.primaryOnboardingLogo,
      'secondaryOnboardingLogo': instance.secondaryOnboardingLogo,
    };

_$_ColorSchemeOverride _$$_ColorSchemeOverrideFromJson(
        Map<String, dynamic> json) =>
    _$_ColorSchemeOverride(
      primary: json['primary'] as String?,
      onPrimary: json['onPrimary'] as String?,
      primaryContainer: json['primaryContainer'] as String?,
      onPrimaryContainer: json['onPrimaryContainer'] as String?,
      secondary: json['secondary'] as String?,
      onSecondary: json['onSecondary'] as String?,
      secondaryContainer: json['secondaryContainer'] as String?,
      onSecondaryContainer: json['onSecondaryContainer'] as String?,
      tertiary: json['tertiary'] as String?,
      onTertiary: json['onTertiary'] as String?,
      tertiaryContainer: json['tertiaryContainer'] as String?,
      onTertiaryContainer: json['onTertiaryContainer'] as String?,
      error: json['error'] as String?,
      onError: json['onError'] as String?,
      errorContainer: json['errorContainer'] as String?,
      onErrorContainer: json['onErrorContainer'] as String?,
      outline: json['outline'] as String?,
      outlineVariant: json['outlineVariant'] as String?,
      background: json['background'] as String?,
      onBackground: json['onBackground'] as String?,
      surface: json['surface'] as String?,
      onSurface: json['onSurface'] as String?,
      surfaceVariant: json['surfaceVariant'] as String?,
      onSurfaceVariant: json['onSurfaceVariant'] as String?,
      inverseSurface: json['inverseSurface'] as String?,
      onInverseSurface: json['onInverseSurface'] as String?,
      inversePrimary: json['inversePrimary'] as String?,
      shadow: json['shadow'] as String?,
      scrim: json['scrim'] as String?,
      surfaceTint: json['surfaceTint'] as String?,
    );

Map<String, dynamic> _$$_ColorSchemeOverrideToJson(
        _$_ColorSchemeOverride instance) =>
    <String, dynamic>{
      'primary': instance.primary,
      'onPrimary': instance.onPrimary,
      'primaryContainer': instance.primaryContainer,
      'onPrimaryContainer': instance.onPrimaryContainer,
      'secondary': instance.secondary,
      'onSecondary': instance.onSecondary,
      'secondaryContainer': instance.secondaryContainer,
      'onSecondaryContainer': instance.onSecondaryContainer,
      'tertiary': instance.tertiary,
      'onTertiary': instance.onTertiary,
      'tertiaryContainer': instance.tertiaryContainer,
      'onTertiaryContainer': instance.onTertiaryContainer,
      'error': instance.error,
      'onError': instance.onError,
      'errorContainer': instance.errorContainer,
      'onErrorContainer': instance.onErrorContainer,
      'outline': instance.outline,
      'outlineVariant': instance.outlineVariant,
      'background': instance.background,
      'onBackground': instance.onBackground,
      'surface': instance.surface,
      'onSurface': instance.onSurface,
      'surfaceVariant': instance.surfaceVariant,
      'onSurfaceVariant': instance.onSurfaceVariant,
      'inverseSurface': instance.inverseSurface,
      'onInverseSurface': instance.onInverseSurface,
      'inversePrimary': instance.inversePrimary,
      'shadow': instance.shadow,
      'scrim': instance.scrim,
      'surfaceTint': instance.surfaceTint,
    };
