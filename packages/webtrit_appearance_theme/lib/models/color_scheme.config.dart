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
  /// Creates a [ColorSchemeOverride].
  ///
  /// A theme names only the roles it wants different. Every role left out is
  /// generated from the seed colour, which is what the seed is for - giving
  /// each one a fixed fallback here would make the seed decide nothing.
  const ColorSchemeOverride({
    this.primary,
    this.onPrimary,
    this.primaryContainer,
    this.onPrimaryContainer,
    this.primaryFixed,
    this.primaryFixedDim,
    this.onPrimaryFixed,
    this.onPrimaryFixedVariant,
    this.secondary,
    this.onSecondary,
    this.secondaryContainer,
    this.onSecondaryContainer,
    this.secondaryFixed,
    this.secondaryFixedDim,
    this.onSecondaryFixed,
    this.onSecondaryFixedVariant,
    this.tertiary,
    this.onTertiary,
    this.tertiaryContainer,
    this.onTertiaryContainer,
    this.tertiaryFixed,
    this.tertiaryFixedDim,
    this.onTertiaryFixed,
    this.onTertiaryFixedVariant,
    this.error,
    this.onError,
    this.errorContainer,
    this.onErrorContainer,
    this.outline,
    this.outlineVariant,
    this.surface,
    this.onSurface,
    this.surfaceDim,
    this.surfaceBright,
    this.surfaceContainerLowest,
    this.surfaceContainerLow,
    this.surfaceContainer,
    this.surfaceContainerHigh,
    this.surfaceContainerHighest,
    this.onSurfaceVariant,
    this.inverseSurface,
    this.onInverseSurface,
    this.inversePrimary,
    this.shadow,
    this.scrim,
    this.surfaceTint,
  });

  @override
  final String? primary;

  @override
  final String? onPrimary;

  @override
  final String? primaryContainer;

  @override
  final String? onPrimaryContainer;

  @override
  final String? primaryFixed;

  @override
  final String? primaryFixedDim;

  @override
  final String? onPrimaryFixed;

  @override
  final String? onPrimaryFixedVariant;

  @override
  final String? secondary;

  @override
  final String? onSecondary;

  @override
  final String? secondaryContainer;

  @override
  final String? onSecondaryContainer;

  @override
  final String? secondaryFixed;

  @override
  final String? secondaryFixedDim;

  @override
  final String? onSecondaryFixed;

  @override
  final String? onSecondaryFixedVariant;

  @override
  final String? tertiary;

  @override
  final String? onTertiary;

  @override
  final String? tertiaryContainer;

  @override
  final String? onTertiaryContainer;

  @override
  final String? tertiaryFixed;

  @override
  final String? tertiaryFixedDim;

  @override
  final String? onTertiaryFixed;

  @override
  final String? onTertiaryFixedVariant;

  @override
  final String? error;

  @override
  final String? onError;

  @override
  final String? errorContainer;

  @override
  final String? onErrorContainer;

  @override
  final String? outline;

  @override
  final String? outlineVariant;

  @override
  final String? surface;

  @override
  final String? onSurface;

  @override
  final String? surfaceDim;

  @override
  final String? surfaceBright;

  @override
  final String? surfaceContainerLowest;

  @override
  final String? surfaceContainerLow;

  @override
  final String? surfaceContainer;

  @override
  final String? surfaceContainerHigh;

  @override
  final String? surfaceContainerHighest;

  @override
  final String? onSurfaceVariant;

  @override
  final String? inverseSurface;

  @override
  final String? onInverseSurface;

  @override
  final String? inversePrimary;

  @override
  final String? shadow;

  @override
  final String? scrim;

  @override
  final String? surfaceTint;

  factory ColorSchemeOverride.fromJson(Map<String, Object?> json) => _$ColorSchemeOverrideFromJson(json);

  Map<String, Object?> toJson() => _$ColorSchemeOverrideToJson(this);
}
