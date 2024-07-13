// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ThemeSettingsImpl _$$ThemeSettingsImplFromJson(Map<String, dynamic> json) =>
    _$ThemeSettingsImpl(
      seedColor:
          const CSSColorConverter().fromJson(json['seedColor'] as String),
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
      primaryOnboardingLogo:
          ThemeSvgAsset.fromJson(json['primaryOnboardingLogo'] as String),
      secondaryOnboardingLogo:
          ThemeSvgAsset.fromJson(json['secondaryOnboardingLogo'] as String),
    );

Map<String, dynamic> _$$ThemeSettingsImplToJson(_$ThemeSettingsImpl instance) =>
    <String, dynamic>{
      'seedColor': const CSSColorConverter().toJson(instance.seedColor),
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
      primary: _$JsonConverterFromJson<String, Color>(
          json['primary'], const CSSColorConverter().fromJson),
      onPrimary: _$JsonConverterFromJson<String, Color>(
          json['onPrimary'], const CSSColorConverter().fromJson),
      primaryContainer: _$JsonConverterFromJson<String, Color>(
          json['primaryContainer'], const CSSColorConverter().fromJson),
      onPrimaryContainer: _$JsonConverterFromJson<String, Color>(
          json['onPrimaryContainer'], const CSSColorConverter().fromJson),
      primaryFixed: _$JsonConverterFromJson<String, Color>(
          json['primaryFixed'], const CSSColorConverter().fromJson),
      primaryFixedDim: _$JsonConverterFromJson<String, Color>(
          json['primaryFixedDim'], const CSSColorConverter().fromJson),
      onPrimaryFixed: _$JsonConverterFromJson<String, Color>(
          json['onPrimaryFixed'], const CSSColorConverter().fromJson),
      onPrimaryFixedVariant: _$JsonConverterFromJson<String, Color>(
          json['onPrimaryFixedVariant'], const CSSColorConverter().fromJson),
      secondary: _$JsonConverterFromJson<String, Color>(
          json['secondary'], const CSSColorConverter().fromJson),
      onSecondary: _$JsonConverterFromJson<String, Color>(
          json['onSecondary'], const CSSColorConverter().fromJson),
      secondaryContainer: _$JsonConverterFromJson<String, Color>(
          json['secondaryContainer'], const CSSColorConverter().fromJson),
      onSecondaryContainer: _$JsonConverterFromJson<String, Color>(
          json['onSecondaryContainer'], const CSSColorConverter().fromJson),
      secondaryFixed: _$JsonConverterFromJson<String, Color>(
          json['secondaryFixed'], const CSSColorConverter().fromJson),
      secondaryFixedDim: _$JsonConverterFromJson<String, Color>(
          json['secondaryFixedDim'], const CSSColorConverter().fromJson),
      onSecondaryFixed: _$JsonConverterFromJson<String, Color>(
          json['onSecondaryFixed'], const CSSColorConverter().fromJson),
      onSecondaryFixedVariant: _$JsonConverterFromJson<String, Color>(
          json['onSecondaryFixedVariant'], const CSSColorConverter().fromJson),
      tertiary: _$JsonConverterFromJson<String, Color>(
          json['tertiary'], const CSSColorConverter().fromJson),
      onTertiary: _$JsonConverterFromJson<String, Color>(
          json['onTertiary'], const CSSColorConverter().fromJson),
      tertiaryContainer: _$JsonConverterFromJson<String, Color>(
          json['tertiaryContainer'], const CSSColorConverter().fromJson),
      onTertiaryContainer: _$JsonConverterFromJson<String, Color>(
          json['onTertiaryContainer'], const CSSColorConverter().fromJson),
      tertiaryFixed: _$JsonConverterFromJson<String, Color>(
          json['tertiaryFixed'], const CSSColorConverter().fromJson),
      tertiaryFixedDim: _$JsonConverterFromJson<String, Color>(
          json['tertiaryFixedDim'], const CSSColorConverter().fromJson),
      onTertiaryFixed: _$JsonConverterFromJson<String, Color>(
          json['onTertiaryFixed'], const CSSColorConverter().fromJson),
      onTertiaryFixedVariant: _$JsonConverterFromJson<String, Color>(
          json['onTertiaryFixedVariant'], const CSSColorConverter().fromJson),
      error: _$JsonConverterFromJson<String, Color>(
          json['error'], const CSSColorConverter().fromJson),
      onError: _$JsonConverterFromJson<String, Color>(
          json['onError'], const CSSColorConverter().fromJson),
      errorContainer: _$JsonConverterFromJson<String, Color>(
          json['errorContainer'], const CSSColorConverter().fromJson),
      onErrorContainer: _$JsonConverterFromJson<String, Color>(
          json['onErrorContainer'], const CSSColorConverter().fromJson),
      outline: _$JsonConverterFromJson<String, Color>(
          json['outline'], const CSSColorConverter().fromJson),
      outlineVariant: _$JsonConverterFromJson<String, Color>(
          json['outlineVariant'], const CSSColorConverter().fromJson),
      surface: _$JsonConverterFromJson<String, Color>(
          json['surface'], const CSSColorConverter().fromJson),
      onSurface: _$JsonConverterFromJson<String, Color>(
          json['onSurface'], const CSSColorConverter().fromJson),
      surfaceDim: _$JsonConverterFromJson<String, Color>(
          json['surfaceDim'], const CSSColorConverter().fromJson),
      surfaceBright: _$JsonConverterFromJson<String, Color>(
          json['surfaceBright'], const CSSColorConverter().fromJson),
      surfaceContainerLowest: _$JsonConverterFromJson<String, Color>(
          json['surfaceContainerLowest'], const CSSColorConverter().fromJson),
      surfaceContainerLow: _$JsonConverterFromJson<String, Color>(
          json['surfaceContainerLow'], const CSSColorConverter().fromJson),
      surfaceContainer: _$JsonConverterFromJson<String, Color>(
          json['surfaceContainer'], const CSSColorConverter().fromJson),
      surfaceContainerHigh: _$JsonConverterFromJson<String, Color>(
          json['surfaceContainerHigh'], const CSSColorConverter().fromJson),
      surfaceContainerHighest: _$JsonConverterFromJson<String, Color>(
          json['surfaceContainerHighest'], const CSSColorConverter().fromJson),
      onSurfaceVariant: _$JsonConverterFromJson<String, Color>(
          json['onSurfaceVariant'], const CSSColorConverter().fromJson),
      inverseSurface: _$JsonConverterFromJson<String, Color>(
          json['inverseSurface'], const CSSColorConverter().fromJson),
      onInverseSurface: _$JsonConverterFromJson<String, Color>(
          json['onInverseSurface'], const CSSColorConverter().fromJson),
      inversePrimary: _$JsonConverterFromJson<String, Color>(
          json['inversePrimary'], const CSSColorConverter().fromJson),
      shadow: _$JsonConverterFromJson<String, Color>(
          json['shadow'], const CSSColorConverter().fromJson),
      scrim: _$JsonConverterFromJson<String, Color>(
          json['scrim'], const CSSColorConverter().fromJson),
      surfaceTint: _$JsonConverterFromJson<String, Color>(
          json['surfaceTint'], const CSSColorConverter().fromJson),
    );

Map<String, dynamic> _$$ColorSchemeOverrideImplToJson(
        _$ColorSchemeOverrideImpl instance) =>
    <String, dynamic>{
      'primary': _$JsonConverterToJson<String, Color>(
          instance.primary, const CSSColorConverter().toJson),
      'onPrimary': _$JsonConverterToJson<String, Color>(
          instance.onPrimary, const CSSColorConverter().toJson),
      'primaryContainer': _$JsonConverterToJson<String, Color>(
          instance.primaryContainer, const CSSColorConverter().toJson),
      'onPrimaryContainer': _$JsonConverterToJson<String, Color>(
          instance.onPrimaryContainer, const CSSColorConverter().toJson),
      'primaryFixed': _$JsonConverterToJson<String, Color>(
          instance.primaryFixed, const CSSColorConverter().toJson),
      'primaryFixedDim': _$JsonConverterToJson<String, Color>(
          instance.primaryFixedDim, const CSSColorConverter().toJson),
      'onPrimaryFixed': _$JsonConverterToJson<String, Color>(
          instance.onPrimaryFixed, const CSSColorConverter().toJson),
      'onPrimaryFixedVariant': _$JsonConverterToJson<String, Color>(
          instance.onPrimaryFixedVariant, const CSSColorConverter().toJson),
      'secondary': _$JsonConverterToJson<String, Color>(
          instance.secondary, const CSSColorConverter().toJson),
      'onSecondary': _$JsonConverterToJson<String, Color>(
          instance.onSecondary, const CSSColorConverter().toJson),
      'secondaryContainer': _$JsonConverterToJson<String, Color>(
          instance.secondaryContainer, const CSSColorConverter().toJson),
      'onSecondaryContainer': _$JsonConverterToJson<String, Color>(
          instance.onSecondaryContainer, const CSSColorConverter().toJson),
      'secondaryFixed': _$JsonConverterToJson<String, Color>(
          instance.secondaryFixed, const CSSColorConverter().toJson),
      'secondaryFixedDim': _$JsonConverterToJson<String, Color>(
          instance.secondaryFixedDim, const CSSColorConverter().toJson),
      'onSecondaryFixed': _$JsonConverterToJson<String, Color>(
          instance.onSecondaryFixed, const CSSColorConverter().toJson),
      'onSecondaryFixedVariant': _$JsonConverterToJson<String, Color>(
          instance.onSecondaryFixedVariant, const CSSColorConverter().toJson),
      'tertiary': _$JsonConverterToJson<String, Color>(
          instance.tertiary, const CSSColorConverter().toJson),
      'onTertiary': _$JsonConverterToJson<String, Color>(
          instance.onTertiary, const CSSColorConverter().toJson),
      'tertiaryContainer': _$JsonConverterToJson<String, Color>(
          instance.tertiaryContainer, const CSSColorConverter().toJson),
      'onTertiaryContainer': _$JsonConverterToJson<String, Color>(
          instance.onTertiaryContainer, const CSSColorConverter().toJson),
      'tertiaryFixed': _$JsonConverterToJson<String, Color>(
          instance.tertiaryFixed, const CSSColorConverter().toJson),
      'tertiaryFixedDim': _$JsonConverterToJson<String, Color>(
          instance.tertiaryFixedDim, const CSSColorConverter().toJson),
      'onTertiaryFixed': _$JsonConverterToJson<String, Color>(
          instance.onTertiaryFixed, const CSSColorConverter().toJson),
      'onTertiaryFixedVariant': _$JsonConverterToJson<String, Color>(
          instance.onTertiaryFixedVariant, const CSSColorConverter().toJson),
      'error': _$JsonConverterToJson<String, Color>(
          instance.error, const CSSColorConverter().toJson),
      'onError': _$JsonConverterToJson<String, Color>(
          instance.onError, const CSSColorConverter().toJson),
      'errorContainer': _$JsonConverterToJson<String, Color>(
          instance.errorContainer, const CSSColorConverter().toJson),
      'onErrorContainer': _$JsonConverterToJson<String, Color>(
          instance.onErrorContainer, const CSSColorConverter().toJson),
      'outline': _$JsonConverterToJson<String, Color>(
          instance.outline, const CSSColorConverter().toJson),
      'outlineVariant': _$JsonConverterToJson<String, Color>(
          instance.outlineVariant, const CSSColorConverter().toJson),
      'surface': _$JsonConverterToJson<String, Color>(
          instance.surface, const CSSColorConverter().toJson),
      'onSurface': _$JsonConverterToJson<String, Color>(
          instance.onSurface, const CSSColorConverter().toJson),
      'surfaceDim': _$JsonConverterToJson<String, Color>(
          instance.surfaceDim, const CSSColorConverter().toJson),
      'surfaceBright': _$JsonConverterToJson<String, Color>(
          instance.surfaceBright, const CSSColorConverter().toJson),
      'surfaceContainerLowest': _$JsonConverterToJson<String, Color>(
          instance.surfaceContainerLowest, const CSSColorConverter().toJson),
      'surfaceContainerLow': _$JsonConverterToJson<String, Color>(
          instance.surfaceContainerLow, const CSSColorConverter().toJson),
      'surfaceContainer': _$JsonConverterToJson<String, Color>(
          instance.surfaceContainer, const CSSColorConverter().toJson),
      'surfaceContainerHigh': _$JsonConverterToJson<String, Color>(
          instance.surfaceContainerHigh, const CSSColorConverter().toJson),
      'surfaceContainerHighest': _$JsonConverterToJson<String, Color>(
          instance.surfaceContainerHighest, const CSSColorConverter().toJson),
      'onSurfaceVariant': _$JsonConverterToJson<String, Color>(
          instance.onSurfaceVariant, const CSSColorConverter().toJson),
      'inverseSurface': _$JsonConverterToJson<String, Color>(
          instance.inverseSurface, const CSSColorConverter().toJson),
      'onInverseSurface': _$JsonConverterToJson<String, Color>(
          instance.onInverseSurface, const CSSColorConverter().toJson),
      'inversePrimary': _$JsonConverterToJson<String, Color>(
          instance.inversePrimary, const CSSColorConverter().toJson),
      'shadow': _$JsonConverterToJson<String, Color>(
          instance.shadow, const CSSColorConverter().toJson),
      'scrim': _$JsonConverterToJson<String, Color>(
          instance.scrim, const CSSColorConverter().toJson),
      'surfaceTint': _$JsonConverterToJson<String, Color>(
          instance.surfaceTint, const CSSColorConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
