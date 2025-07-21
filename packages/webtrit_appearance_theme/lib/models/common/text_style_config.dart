import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_style_config.freezed.dart';

part 'text_style_config.g.dart';

/// Represents a configurable text style used for UI theming.
@Freezed()
class TextStyleConfig with _$TextStyleConfig {
  @JsonSerializable(explicitToJson: true)
  const factory TextStyleConfig({
    /// The name of the font family to use (e.g., "Roboto").
    String? fontFamily,

    /// The size of glyphs (e.g., 14.0).
    double? fontSize,

    /// The thickness of the glyphs.
    FontWeightConfig? fontWeight,

    /// Whether the glyphs should be italicized.
    FontStyleConfig? fontStyle,

    /// The text color in hex format (e.g., "#FF0000").
    String? color,

    /// The spacing between letters, in logical pixels.
    double? letterSpacing,

    /// The spacing between words, in logical pixels.
    double? wordSpacing,

    /// The line height, as a multiplier of font size.
    double? height,

    /// Decorations like underline or strikethrough.
    TextDecorationConfig? decoration,

    /// Background color for the text in hex format.
    String? backgroundColor,
  }) = _TextStyleConfig;

  factory TextStyleConfig.fromJson(Map<String, dynamic> json) => _$TextStyleConfigFromJson(json);
}

/// Represents font weight using numeric value (e.g., 400 for normal).
@freezed
class FontWeightConfig with _$FontWeightConfig {
  /// Creates a [FontWeightConfig] with the given numeric weight.
  /// Common values: 100 (thin), 400 (normal), 700 (bold), 900 (black).
  const factory FontWeightConfig({
    required int weight,
  }) = _FontWeightConfig;

  factory FontWeightConfig.fromJson(Map<String, dynamic> json) => _$FontWeightConfigFromJson(json);
}

/// Represents font style — either normal or italic.
@freezed
class FontStyleConfig with _$FontStyleConfig {
  /// The font style, as a string. Common values: `"normal"`, `"italic"`.
  const factory FontStyleConfig({
    @Default('normal') String value,
  }) = _FontStyleConfig;

  factory FontStyleConfig.fromJson(Map<String, dynamic> json) => _$FontStyleConfigFromJson(json);
}

/// Represents text decorations such as underline or line-through.
@freezed
class TextDecorationConfig with _$TextDecorationConfig {
  /// A list of decoration types. Supported values:
  /// `"underline"`, `"lineThrough"`, `"overline"`.
  const factory TextDecorationConfig({
    @Default([]) List<String> types,
  }) = _TextDecorationConfig;

  factory TextDecorationConfig.fromJson(Map<String, dynamic> json) => _$TextDecorationConfigFromJson(json);
}
