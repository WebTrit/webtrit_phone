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
      darkColorSchemeOverride: json['darkColorSchemeOverride'] == null
          ? null
          : ColorSchemeOverride.fromJson(
              json['darkColorSchemeOverride'] as Map<String, dynamic>),
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
      'darkColorSchemeOverride': instance.darkColorSchemeOverride,
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
      secondary: _$JsonConverterFromJson<String, Color>(
          json['secondary'], const CSSColorConverter().fromJson),
      onSecondary: _$JsonConverterFromJson<String, Color>(
          json['onSecondary'], const CSSColorConverter().fromJson),
      secondaryContainer: _$JsonConverterFromJson<String, Color>(
          json['secondaryContainer'], const CSSColorConverter().fromJson),
      onSecondaryContainer: _$JsonConverterFromJson<String, Color>(
          json['onSecondaryContainer'], const CSSColorConverter().fromJson),
      tertiary: _$JsonConverterFromJson<String, Color>(
          json['tertiary'], const CSSColorConverter().fromJson),
      onTertiary: _$JsonConverterFromJson<String, Color>(
          json['onTertiary'], const CSSColorConverter().fromJson),
      tertiaryContainer: _$JsonConverterFromJson<String, Color>(
          json['tertiaryContainer'], const CSSColorConverter().fromJson),
      onTertiaryContainer: _$JsonConverterFromJson<String, Color>(
          json['onTertiaryContainer'], const CSSColorConverter().fromJson),
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
      background: _$JsonConverterFromJson<String, Color>(
          json['background'], const CSSColorConverter().fromJson),
      onBackground: _$JsonConverterFromJson<String, Color>(
          json['onBackground'], const CSSColorConverter().fromJson),
      surface: _$JsonConverterFromJson<String, Color>(
          json['surface'], const CSSColorConverter().fromJson),
      onSurface: _$JsonConverterFromJson<String, Color>(
          json['onSurface'], const CSSColorConverter().fromJson),
      surfaceVariant: _$JsonConverterFromJson<String, Color>(
          json['surfaceVariant'], const CSSColorConverter().fromJson),
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
      'secondary': _$JsonConverterToJson<String, Color>(
          instance.secondary, const CSSColorConverter().toJson),
      'onSecondary': _$JsonConverterToJson<String, Color>(
          instance.onSecondary, const CSSColorConverter().toJson),
      'secondaryContainer': _$JsonConverterToJson<String, Color>(
          instance.secondaryContainer, const CSSColorConverter().toJson),
      'onSecondaryContainer': _$JsonConverterToJson<String, Color>(
          instance.onSecondaryContainer, const CSSColorConverter().toJson),
      'tertiary': _$JsonConverterToJson<String, Color>(
          instance.tertiary, const CSSColorConverter().toJson),
      'onTertiary': _$JsonConverterToJson<String, Color>(
          instance.onTertiary, const CSSColorConverter().toJson),
      'tertiaryContainer': _$JsonConverterToJson<String, Color>(
          instance.tertiaryContainer, const CSSColorConverter().toJson),
      'onTertiaryContainer': _$JsonConverterToJson<String, Color>(
          instance.onTertiaryContainer, const CSSColorConverter().toJson),
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
      'background': _$JsonConverterToJson<String, Color>(
          instance.background, const CSSColorConverter().toJson),
      'onBackground': _$JsonConverterToJson<String, Color>(
          instance.onBackground, const CSSColorConverter().toJson),
      'surface': _$JsonConverterToJson<String, Color>(
          instance.surface, const CSSColorConverter().toJson),
      'onSurface': _$JsonConverterToJson<String, Color>(
          instance.onSurface, const CSSColorConverter().toJson),
      'surfaceVariant': _$JsonConverterToJson<String, Color>(
          instance.surfaceVariant, const CSSColorConverter().toJson),
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
