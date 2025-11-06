import 'package:freezed_annotation/freezed_annotation.dart';

part 'color_scheme.config.freezed.dart';

part 'color_scheme.config.g.dart';

@freezed
@JsonSerializable(explicitToJson: true)
class ColorSchemeConfig with _$ColorSchemeConfig {
  /// Creates a [ColorSchemeConfig].
  const ColorSchemeConfig({this.seedColor = '#F95A14', this.colorSchemeOverride = const ColorSchemeOverride()});

  /// The seed color used to generate tonal palettes for the theme.
  @override
  final String seedColor;

  /// Explicit overrides for the generated color scheme.
  @override
  final ColorSchemeOverride colorSchemeOverride;

  factory ColorSchemeConfig.fromJson(Map<String, Object?> json) => _$ColorSchemeConfigFromJson(json);

  Map<String, Object?> toJson() => _$ColorSchemeConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class ColorSchemeOverride with _$ColorSchemeOverride {
  /// Creates a [ColorSchemeOverride] that defines all color roles for the app theme.
  const ColorSchemeOverride({
    this.primary = '#5CACE3',
    this.onPrimary = '#FFFFFF',
    this.primaryContainer = '#B9E3F9',
    this.onPrimaryContainer = '#123752',
    this.primaryFixed = '#A5C6E4',
    this.primaryFixedDim = '#75A1C5',
    this.onPrimaryFixed = '#092D4A',
    this.onPrimaryFixedVariant = '#A5C6E4',
    this.secondary = '#123752',
    this.onSecondary = '#FFFFFF',
    this.secondaryContainer = '#EEF3F6',
    this.onSecondaryContainer = '#1F618F',
    this.secondaryFixed = '#848581',
    this.secondaryFixedDim = '#4C4D4A',
    this.onSecondaryFixed = '#30302F',
    this.onSecondaryFixedVariant = '#848581',
    this.tertiary = '#75B943',
    this.onTertiary = '#FFFFFF',
    this.tertiaryContainer = '#E1F7C1',
    this.onTertiaryContainer = '#2E5200',
    this.tertiaryFixed = '#B8E078',
    this.tertiaryFixedDim = '#8CC14E',
    this.onTertiaryFixed = '#224400',
    this.onTertiaryFixedVariant = '#B8E078',
    this.error = '#E74C3C',
    this.onError = '#FFFFFF',
    this.errorContainer = '#F5B7B1',
    this.onErrorContainer = '#8B1E13',
    this.outline = '#4C4D4A',
    this.outlineVariant = '#CDCFC9',
    this.surface = '#EEF3F6',
    this.onSurface = '#30302F',
    this.surfaceDim = '#DDE0E3',
    this.surfaceBright = '#FFFFFF',
    this.surfaceContainerLowest = '#F8FBFD',
    this.surfaceContainerLow = '#F0F3F5',
    this.surfaceContainer = '#EEF3F6',
    this.surfaceContainerHigh = '#E2E6E9',
    this.surfaceContainerHighest = '#DDE0E3',
    this.onSurfaceVariant = '#848581',
    this.inverseSurface = '#30302F',
    this.onInverseSurface = '#EEF3F6',
    this.inversePrimary = '#1F618F',
    this.shadow = '#000000',
    this.scrim = '#000000',
    this.surfaceTint = '#F95A14',
  });

  @override
  final String primary;

  @override
  final String onPrimary;

  @override
  final String primaryContainer;

  @override
  final String onPrimaryContainer;

  @override
  final String primaryFixed;

  @override
  final String primaryFixedDim;

  @override
  final String onPrimaryFixed;

  @override
  final String onPrimaryFixedVariant;

  @override
  final String secondary;

  @override
  final String onSecondary;

  @override
  final String secondaryContainer;

  @override
  final String onSecondaryContainer;

  @override
  final String secondaryFixed;

  @override
  final String secondaryFixedDim;

  @override
  final String onSecondaryFixed;

  @override
  final String onSecondaryFixedVariant;

  @override
  final String tertiary;

  @override
  final String onTertiary;

  @override
  final String tertiaryContainer;

  @override
  final String onTertiaryContainer;

  @override
  final String tertiaryFixed;

  @override
  final String tertiaryFixedDim;

  @override
  final String onTertiaryFixed;

  @override
  final String onTertiaryFixedVariant;

  @override
  final String error;

  @override
  final String onError;

  @override
  final String errorContainer;

  @override
  final String onErrorContainer;

  @override
  final String outline;

  @override
  final String outlineVariant;

  @override
  final String surface;

  @override
  final String onSurface;

  @override
  final String surfaceDim;

  @override
  final String surfaceBright;

  @override
  final String surfaceContainerLowest;

  @override
  final String surfaceContainerLow;

  @override
  final String surfaceContainer;

  @override
  final String surfaceContainerHigh;

  @override
  final String surfaceContainerHighest;

  @override
  final String onSurfaceVariant;

  @override
  final String inverseSurface;

  @override
  final String onInverseSurface;

  @override
  final String inversePrimary;

  @override
  final String shadow;

  @override
  final String scrim;

  @override
  final String surfaceTint;

  factory ColorSchemeOverride.fromJson(Map<String, Object?> json) => _$ColorSchemeOverrideFromJson(json);

  Map<String, Object?> toJson() => _$ColorSchemeOverrideToJson(this);
}
