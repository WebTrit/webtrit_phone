import 'package:freezed_annotation/freezed_annotation.dart';

import 'text_style_config.dart';
import 'input_decoration_config.dart';

part 'text_field_config.freezed.dart';

part 'text_field_config.g.dart';

/// Configuration model for customizing a Material [TextField].
///
/// This declarative config mirrors the properties of Flutter’s
/// [TextField](https://api.flutter.dev/flutter/material/TextField-class.html)
/// and follows the guidelines of
/// [Material Design — Text fields](https://m3.material.io/components/text-fields/overview).
///
/// It can be loaded from JSON and applied dynamically in themes or screens.
@freezed
@JsonSerializable(explicitToJson: true)
class TextFieldConfig with _$TextFieldConfig {
  /// Creates a [TextFieldConfig].
  const TextFieldConfig({
    /// Input decoration (borders, hints, labels, etc.).
    ///
    /// Use `border.type = "none"` (or `enabledBorder/focusedBorder/... = "none"`)
    /// to completely remove the underline/outline.
    this.decoration,

    /// Style for the text inside the field.
    this.style,

    /// Text alignment inside the field.
    ///
    /// Supported values: `"left" | "right" | "center"`.
    this.textAlign = 'center',

    /// Whether the blinking cursor is visible.
    this.showCursor = true,

    /// Keyboard type for this field.
    ///
    /// Supported values: `"none" | "number" | "text" | "phone" | "email" | "multiline"`.
    this.keyboardType = 'none',
  });

  /// Input decoration (borders, hints, labels, etc.).
  @override
  final InputDecorationConfig? decoration;

  /// Style for the text inside the field.
  @override
  final TextStyleConfig? style;

  /// Text alignment inside the field.
  ///
  /// Supported values: `"left" | "right" | "center"`.
  @override
  final String textAlign;

  /// Whether the blinking cursor is visible.
  @override
  final bool showCursor;

  /// Keyboard type for this field.
  ///
  /// Supported values: `"none" | "number" | "text" | "phone" | "email" | "multiline"`.
  @override
  final String keyboardType;

  /// Deserializes a [TextFieldConfig] from JSON.
  factory TextFieldConfig.fromJson(Map<String, Object?> json) => _$TextFieldConfigFromJson(json);

  /// Serializes this [TextFieldConfig] to JSON.
  Map<String, Object?> toJson() => _$TextFieldConfigToJson(this);
}
