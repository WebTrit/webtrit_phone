// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_scheme.config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColorSchemeConfig _$ColorSchemeConfigFromJson(Map<String, dynamic> json) =>
    ColorSchemeConfig(
      seedColor: json['seedColor'] as String? ?? '#F95A14',
      colorSchemeOverride: json['colorSchemeOverride'] == null
          ? const ColorSchemeOverride()
          : ColorSchemeOverride.fromJson(
              json['colorSchemeOverride'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ColorSchemeConfigToJson(ColorSchemeConfig instance) =>
    <String, dynamic>{
      'seedColor': instance.seedColor,
      'colorSchemeOverride': instance.colorSchemeOverride.toJson(),
    };

ColorSchemeOverride _$ColorSchemeOverrideFromJson(
  Map<String, dynamic> json,
) => ColorSchemeOverride(
  primary: json['primary'] as String? ?? '#5CACE3',
  onPrimary: json['onPrimary'] as String? ?? '#FFFFFF',
  primaryContainer: json['primaryContainer'] as String? ?? '#B9E3F9',
  onPrimaryContainer: json['onPrimaryContainer'] as String? ?? '#123752',
  primaryFixed: json['primaryFixed'] as String? ?? '#A5C6E4',
  primaryFixedDim: json['primaryFixedDim'] as String? ?? '#75A1C5',
  onPrimaryFixed: json['onPrimaryFixed'] as String? ?? '#092D4A',
  onPrimaryFixedVariant: json['onPrimaryFixedVariant'] as String? ?? '#A5C6E4',
  secondary: json['secondary'] as String? ?? '#123752',
  onSecondary: json['onSecondary'] as String? ?? '#FFFFFF',
  secondaryContainer: json['secondaryContainer'] as String? ?? '#EEF3F6',
  onSecondaryContainer: json['onSecondaryContainer'] as String? ?? '#1F618F',
  secondaryFixed: json['secondaryFixed'] as String? ?? '#848581',
  secondaryFixedDim: json['secondaryFixedDim'] as String? ?? '#4C4D4A',
  onSecondaryFixed: json['onSecondaryFixed'] as String? ?? '#30302F',
  onSecondaryFixedVariant:
      json['onSecondaryFixedVariant'] as String? ?? '#848581',
  tertiary: json['tertiary'] as String? ?? '#75B943',
  onTertiary: json['onTertiary'] as String? ?? '#FFFFFF',
  tertiaryContainer: json['tertiaryContainer'] as String? ?? '#E1F7C1',
  onTertiaryContainer: json['onTertiaryContainer'] as String? ?? '#2E5200',
  tertiaryFixed: json['tertiaryFixed'] as String? ?? '#B8E078',
  tertiaryFixedDim: json['tertiaryFixedDim'] as String? ?? '#8CC14E',
  onTertiaryFixed: json['onTertiaryFixed'] as String? ?? '#224400',
  onTertiaryFixedVariant:
      json['onTertiaryFixedVariant'] as String? ?? '#B8E078',
  error: json['error'] as String? ?? '#E74C3C',
  onError: json['onError'] as String? ?? '#FFFFFF',
  errorContainer: json['errorContainer'] as String? ?? '#F5B7B1',
  onErrorContainer: json['onErrorContainer'] as String? ?? '#8B1E13',
  outline: json['outline'] as String? ?? '#4C4D4A',
  outlineVariant: json['outlineVariant'] as String? ?? '#CDCFC9',
  surface: json['surface'] as String? ?? '#EEF3F6',
  onSurface: json['onSurface'] as String? ?? '#30302F',
  surfaceDim: json['surfaceDim'] as String? ?? '#DDE0E3',
  surfaceBright: json['surfaceBright'] as String? ?? '#FFFFFF',
  surfaceContainerLowest:
      json['surfaceContainerLowest'] as String? ?? '#F8FBFD',
  surfaceContainerLow: json['surfaceContainerLow'] as String? ?? '#F0F3F5',
  surfaceContainer: json['surfaceContainer'] as String? ?? '#EEF3F6',
  surfaceContainerHigh: json['surfaceContainerHigh'] as String? ?? '#E2E6E9',
  surfaceContainerHighest:
      json['surfaceContainerHighest'] as String? ?? '#DDE0E3',
  onSurfaceVariant: json['onSurfaceVariant'] as String? ?? '#848581',
  inverseSurface: json['inverseSurface'] as String? ?? '#30302F',
  onInverseSurface: json['onInverseSurface'] as String? ?? '#EEF3F6',
  inversePrimary: json['inversePrimary'] as String? ?? '#1F618F',
  shadow: json['shadow'] as String? ?? '#000000',
  scrim: json['scrim'] as String? ?? '#000000',
  surfaceTint: json['surfaceTint'] as String? ?? '#F95A14',
);

Map<String, dynamic> _$ColorSchemeOverrideToJson(
  ColorSchemeOverride instance,
) => <String, dynamic>{
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
