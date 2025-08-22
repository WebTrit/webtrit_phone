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
class TextFieldConfig with _$TextFieldConfig {
  @JsonSerializable(explicitToJson: true)
  const factory TextFieldConfig({
    /// Input decoration (borders, hints, labels, etc.).
    ///
    /// Use `border.type = "none"` (or `enabledBorder/focusedBorder/... = "none"`)
    /// to completely remove the underline/outline.
    InputDecorationConfig? decoration,

    /// Style for the text inside the field.
    TextStyleConfig? style,

    /// Text alignment inside the field.
    ///
    /// Supported values: `"left" | "right" | "center"`.
    @Default('center') String textAlign,

    /// Whether the blinking cursor is visible.
    @Default(true) bool showCursor,

    /// Keyboard type for this field.
    ///
    /// Supported values: `"none" | "number" | "text" | "phone" | "email" | "multiline"`.
    @Default('none') String keyboardType,
  }) = _TextFieldConfig;

  factory TextFieldConfig.fromJson(Map<String, dynamic> json) => _$TextFieldConfigFromJson(json);
}
