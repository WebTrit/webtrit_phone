import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_style_config.freezed.dart';

part 'text_style_config.g.dart';

/// Represents a configurable text style used for UI theming.
@freezed
@JsonSerializable(explicitToJson: true)
class TextStyleConfig with _$TextStyleConfig {
  /// Creates a [TextStyleConfig].
  const TextStyleConfig({
    /// The name of the font family to use (e.g., "Roboto").
    this.fontFamily,

    /// The size of glyphs (e.g., 14.0).
    this.fontSize,

    /// The thickness of the glyphs.
    this.fontWeight,

    /// Whether the glyphs should be italicized.
    this.fontStyle,

    /// The text color in hex format (e.g., "#FF0000").
    this.color,

    /// The spacing between letters, in logical pixels.
    this.letterSpacing,

    /// The spacing between words, in logical pixels.
    this.wordSpacing,

    /// The line height, as a multiplier of font size.
    this.height,

    /// Decorations like underline or strikethrough.
    this.decoration,

    /// Background color for the text in hex format.
    this.backgroundColor,
  });

  /// The name of the font family to use (e.g., "Roboto").
  @override
  final String? fontFamily;

  /// The size of glyphs (e.g., 14.0).
  @override
  final double? fontSize;

  /// The thickness of the glyphs.
  @override
  final FontWeightConfig? fontWeight;

  /// Whether the glyphs should be italicized.
  @override
  final FontStyleConfig? fontStyle;

  /// The text color in hex format (e.g., "#FF0000").
  @override
  final String? color;

  /// The spacing between letters, in logical pixels.
  @override
  final double? letterSpacing;

  /// The spacing between words, in logical pixels.
  @override
  final double? wordSpacing;

  /// The line height, as a multiplier of font size.
  @override
  final double? height;

  /// Decorations like underline or strikethrough.
  @override
  final TextDecorationConfig? decoration;

  /// Background color for the text in hex format.
  @override
  final String? backgroundColor;

  factory TextStyleConfig.fromJson(Map<String, Object?> json) =>
      _$TextStyleConfigFromJson(json);

  Map<String, Object?> toJson() => _$TextStyleConfigToJson(this);
}

/// Represents font weight using numeric value (e.g., 400 for normal).
@freezed
@JsonSerializable()
class FontWeightConfig with _$FontWeightConfig {
  /// Creates a [FontWeightConfig] with the given numeric weight.
  /// Common values: 100 (thin), 400 (normal), 700 (bold), 900 (black).
  const FontWeightConfig({required this.weight});

  /// Numeric weight of the font (100–900 typical).
  @override
  final int weight;

  factory FontWeightConfig.fromJson(Map<String, Object?> json) =>
      _$FontWeightConfigFromJson(json);

  Map<String, Object?> toJson() => _$FontWeightConfigToJson(this);
}

/// Represents font style — either normal or italic.
@freezed
@JsonSerializable()
class FontStyleConfig with _$FontStyleConfig {
  /// Creates a [FontStyleConfig].
  const FontStyleConfig({
    /// The font style, as a string. Common values: `"normal"`, `"italic"`.
    this.value = 'normal',
  });

  /// The font style, as a string. Common values: `"normal"`, `"italic"`.
  @override
  final String value;

  factory FontStyleConfig.fromJson(Map<String, Object?> json) =>
      _$FontStyleConfigFromJson(json);

  Map<String, Object?> toJson() => _$FontStyleConfigToJson(this);
}

/// Represents text decorations such as underline or line-through.
@freezed
@JsonSerializable()
class TextDecorationConfig with _$TextDecorationConfig {
  /// Creates a [TextDecorationConfig].
  ///
  /// A list of decoration types. Supported values:
  /// `"underline"`, `"lineThrough"`, `"overline"`.
  const TextDecorationConfig({this.types = const []});

  /// A list of decoration types. Supported values:
  /// `"underline"`, `"lineThrough"`, `"overline"`.
  @override
  final List<String> types;

  factory TextDecorationConfig.fromJson(Map<String, Object?> json) =>
      _$TextDecorationConfigFromJson(json);

  Map<String, Object?> toJson() => _$TextDecorationConfigToJson(this);
}
