// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ThemeSettingsImpl _$$ThemeSettingsImplFromJson(Map<String, dynamic> json) =>
    _$ThemeSettingsImpl(
      seedColor: json['seedColor'] as String,
      lightColorSchemeOverride: json['lightColorSchemeOverride'] == null
          ? null
          : ColorSchemeOverride.fromJson(
              json['lightColorSchemeOverride'] as Map<String, dynamic>),
      themeWidgetLightConfig: json['themeWidgetLightConfig'] == null
          ? null
          : ThemeWidgetConfig.fromJson(
              json['themeWidgetLightConfig'] as Map<String, dynamic>),
      themePageLightConfig: json['themePageLightConfig'] == null
          ? null
          : ThemePageConfig.fromJson(
              json['themePageLightConfig'] as Map<String, dynamic>),
      darkColorSchemeOverride: json['darkColorSchemeOverride'] == null
          ? null
          : ColorSchemeOverride.fromJson(
              json['darkColorSchemeOverride'] as Map<String, dynamic>),
      themeWidgetDarkConfig: json['themeWidgetDarkConfig'] == null
          ? null
          : ThemeWidgetConfig.fromJson(
              json['themeWidgetDarkConfig'] as Map<String, dynamic>),
      themePageDarkConfig: json['themePageDarkConfig'] == null
          ? null
          : ThemePageConfig.fromJson(
              json['themePageDarkConfig'] as Map<String, dynamic>),
      primaryGradientColors: (json['primaryGradientColors'] as List<dynamic>)
          .map((e) => CustomColor.fromJson(e as Map<String, dynamic>))
          .toList(),
      fontFamily: json['fontFamily'] as String?,
      primaryOnboardingLogo: json['primaryOnboardingLogo'] as String,
      secondaryOnboardingLogo: json['secondaryOnboardingLogo'] as String,
    );

Map<String, dynamic> _$$ThemeSettingsImplToJson(_$ThemeSettingsImpl instance) =>
    <String, dynamic>{
      'seedColor': instance.seedColor,
      'lightColorSchemeOverride': instance.lightColorSchemeOverride,
      'themeWidgetLightConfig': instance.themeWidgetLightConfig,
      'themePageLightConfig': instance.themePageLightConfig,
      'darkColorSchemeOverride': instance.darkColorSchemeOverride,
      'themeWidgetDarkConfig': instance.themeWidgetDarkConfig,
      'themePageDarkConfig': instance.themePageDarkConfig,
      'primaryGradientColors': instance.primaryGradientColors,
      'fontFamily': instance.fontFamily,
      'primaryOnboardingLogo': instance.primaryOnboardingLogo,
      'secondaryOnboardingLogo': instance.secondaryOnboardingLogo,
    };

_$ColorSchemeOverrideImpl _$$ColorSchemeOverrideImplFromJson(
        Map<String, dynamic> json) =>
    _$ColorSchemeOverrideImpl(
      primary: json['primary'] as String?,
      onPrimary: json['onPrimary'] as String?,
      primaryContainer: json['primaryContainer'] as String?,
      onPrimaryContainer: json['onPrimaryContainer'] as String?,
      primaryFixed: json['primaryFixed'] as String?,
      primaryFixedDim: json['primaryFixedDim'] as String?,
      onPrimaryFixed: json['onPrimaryFixed'] as String?,
      onPrimaryFixedVariant: json['onPrimaryFixedVariant'] as String?,
      secondary: json['secondary'] as String?,
      onSecondary: json['onSecondary'] as String?,
      secondaryContainer: json['secondaryContainer'] as String?,
      onSecondaryContainer: json['onSecondaryContainer'] as String?,
      secondaryFixed: json['secondaryFixed'] as String?,
      secondaryFixedDim: json['secondaryFixedDim'] as String?,
      onSecondaryFixed: json['onSecondaryFixed'] as String?,
      onSecondaryFixedVariant: json['onSecondaryFixedVariant'] as String?,
      tertiary: json['tertiary'] as String?,
      onTertiary: json['onTertiary'] as String?,
      tertiaryContainer: json['tertiaryContainer'] as String?,
      onTertiaryContainer: json['onTertiaryContainer'] as String?,
      tertiaryFixed: json['tertiaryFixed'] as String?,
      tertiaryFixedDim: json['tertiaryFixedDim'] as String?,
      onTertiaryFixed: json['onTertiaryFixed'] as String?,
      onTertiaryFixedVariant: json['onTertiaryFixedVariant'] as String?,
      error: json['error'] as String?,
      onError: json['onError'] as String?,
      errorContainer: json['errorContainer'] as String?,
      onErrorContainer: json['onErrorContainer'] as String?,
      outline: json['outline'] as String?,
      outlineVariant: json['outlineVariant'] as String?,
      surface: json['surface'] as String?,
      onSurface: json['onSurface'] as String?,
      surfaceDim: json['surfaceDim'] as String?,
      surfaceBright: json['surfaceBright'] as String?,
      surfaceContainerLowest: json['surfaceContainerLowest'] as String?,
      surfaceContainerLow: json['surfaceContainerLow'] as String?,
      surfaceContainer: json['surfaceContainer'] as String?,
      surfaceContainerHigh: json['surfaceContainerHigh'] as String?,
      surfaceContainerHighest: json['surfaceContainerHighest'] as String?,
      onSurfaceVariant: json['onSurfaceVariant'] as String?,
      inverseSurface: json['inverseSurface'] as String?,
      onInverseSurface: json['onInverseSurface'] as String?,
      inversePrimary: json['inversePrimary'] as String?,
      shadow: json['shadow'] as String?,
      scrim: json['scrim'] as String?,
      surfaceTint: json['surfaceTint'] as String?,
    );

Map<String, dynamic> _$$ColorSchemeOverrideImplToJson(
        _$ColorSchemeOverrideImpl instance) =>
    <String, dynamic>{
      'primary': instance.primary,
      'onPrimary': instance.onPrimary,
      'primaryContainer': instance.primaryContainer,
      'onPrimaryContainer': instance.onPrimaryContainer,
      'primaryFixed': instance.primaryFixed,
      'primaryFixedDim': instance.primaryFixedDim,
      'onPrimaryFixed': instance.onPrimaryFixed,
      'onPrimaryFixedVariant': instance.onPrimaryFixedVariant,
      'secondary': instance.secondary,
      'onSecondary': instance.onSecondary,
      'secondaryContainer': instance.secondaryContainer,
      'onSecondaryContainer': instance.onSecondaryContainer,
      'secondaryFixed': instance.secondaryFixed,
      'secondaryFixedDim': instance.secondaryFixedDim,
      'onSecondaryFixed': instance.onSecondaryFixed,
      'onSecondaryFixedVariant': instance.onSecondaryFixedVariant,
      'tertiary': instance.tertiary,
      'onTertiary': instance.onTertiary,
      'tertiaryContainer': instance.tertiaryContainer,
      'onTertiaryContainer': instance.onTertiaryContainer,
      'tertiaryFixed': instance.tertiaryFixed,
      'tertiaryFixedDim': instance.tertiaryFixedDim,
      'onTertiaryFixed': instance.onTertiaryFixed,
      'onTertiaryFixedVariant': instance.onTertiaryFixedVariant,
      'error': instance.error,
      'onError': instance.onError,
      'errorContainer': instance.errorContainer,
      'onErrorContainer': instance.onErrorContainer,
      'outline': instance.outline,
      'outlineVariant': instance.outlineVariant,
      'surface': instance.surface,
      'onSurface': instance.onSurface,
      'surfaceDim': instance.surfaceDim,
      'surfaceBright': instance.surfaceBright,
      'surfaceContainerLowest': instance.surfaceContainerLowest,
      'surfaceContainerLow': instance.surfaceContainerLow,
      'surfaceContainer': instance.surfaceContainer,
      'surfaceContainerHigh': instance.surfaceContainerHigh,
      'surfaceContainerHighest': instance.surfaceContainerHighest,
      'onSurfaceVariant': instance.onSurfaceVariant,
      'inverseSurface': instance.inverseSurface,
      'onInverseSurface': instance.onInverseSurface,
      'inversePrimary': instance.inversePrimary,
      'shadow': instance.shadow,
      'scrim': instance.scrim,
      'surfaceTint': instance.surfaceTint,
    };
