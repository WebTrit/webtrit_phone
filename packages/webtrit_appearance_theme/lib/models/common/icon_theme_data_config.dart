import 'package:freezed_annotation/freezed_annotation.dart';

part 'icon_theme_data_config.freezed.dart';

part 'icon_theme_data_config.g.dart';

@freezed
sealed class IconThemeDataConfig with _$IconThemeDataConfig {
  @JsonSerializable(explicitToJson: true)
  const factory IconThemeDataConfig({
    /// The default size for icons.
    double? size,

    /// The default fill for icons (0.0 to 1.0).
    /// Useful for variable fonts (e.g. Material Symbols).
    double? fill,

    /// The default weight for icons (e.g. 400.0).
    /// Useful for variable fonts.
    double? weight,

    /// The default grade for icons.
    /// Useful for variable fonts.
    double? grade,

    /// The default optical size for icons.
    /// Useful for variable fonts.
    double? opticalSize,

    /// The default color for icons (hex string).
    String? color,

    /// An opacity to apply to both explicit and default icon colors.
    double? opacity,

    /// A list of shadows to apply to the icons.
    List<ShadowConfig>? shadows,

    /// Whether to apply text scaling to the icons.
    bool? applyTextScaling,
  }) = _IconThemeDataConfig;

  factory IconThemeDataConfig.fromJson(Map<String, Object?> json) => _$IconThemeDataConfigFromJson(json);
}

@freezed
sealed class ShadowConfig with _$ShadowConfig {
  @JsonSerializable(explicitToJson: true)
  const factory ShadowConfig({
    /// Color of the shadow (hex string).
    String? color,

    /// The displacement of the shadow.
    OffsetConfig? offset,

    /// The blur radius of the shadow.
    @Default(0.0) double blurRadius,
  }) = _ShadowConfig;

  factory ShadowConfig.fromJson(Map<String, Object?> json) => _$ShadowConfigFromJson(json);
}

@freezed
sealed class OffsetConfig with _$OffsetConfig {
  const factory OffsetConfig({@Default(0.0) double dx, @Default(0.0) double dy}) = _OffsetConfig;

  factory OffsetConfig.fromJson(Map<String, Object?> json) => _$OffsetConfigFromJson(json);
}
