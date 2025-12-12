import 'package:freezed_annotation/freezed_annotation.dart';

import 'text_field_mask_config.dart';
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

    /// Input masking configuration.
    this.mask,

    /// Configuration for the logical value and data transformation.
    ///
    /// This controls the **data lifecycle** rather than the visual appearance:
    /// 1. **Initialization**: Sets the starting text state (see [InputValueConfig.initialValue]).
    /// 2. **Submission**: Defines how raw user input is transformed before being emitted
    ///    to business logic (see [InputValueConfig.includePrefixInData]).
    this.inputValue,
  });

  @override
  final InputDecorationConfig? decoration;

  @override
  final TextStyleConfig? style;

  @override
  final String textAlign;

  @override
  final bool showCursor;

  @override
  final String keyboardType;

  @override
  final MaskConfig? mask;

  @override
  final InputValueConfig? inputValue;

  factory TextFieldConfig.fromJson(Map<String, Object?> json) => _$TextFieldConfigFromJson(json);

  Map<String, Object?> toJson() => _$TextFieldConfigToJson(this);
}

/// Configuration for the value/data aspect of the input field.
///
/// This handles the "logical" side of the input: what the initial state is
/// and how the final data should be formatted or transformed before emission.
@freezed
@JsonSerializable()
class InputValueConfig with _$InputValueConfig {
  const InputValueConfig({
    /// When `true`, [prefixText] is treated as part of the logical value.
    ///
    /// If `true`: Emitted value = prefix + user input.
    /// If `false` (default): Emitted value = user input only.
    this.includePrefixInData,

    /// The text value to pre-fill in the input field upon initialization.
    ///
    /// This sets the **initial state** of the text controller.
    /// The user can edit or delete this text.
    ///
    /// This is NOT a placeholder (hint). This is real, mutable text.
    this.initialValue,
  });

  @override
  final bool? includePrefixInData;

  @override
  final String? initialValue;

  factory InputValueConfig.fromJson(Map<String, Object?> json) => _$InputValueConfigFromJson(json);

  Map<String, Object?> toJson() => _$InputValueConfigToJson(this);
}
