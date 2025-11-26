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

    /// Input behavior configuration.
    this.behavior,
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

  @override
  final MaskConfig? mask;

  /// Describes how this field's value should be transformed/emitted.
  @override
  final InputBehaviorConfig? behavior;

  /// Deserializes a [TextFieldConfig] from JSON.
  factory TextFieldConfig.fromJson(Map<String, Object?> json) => _$TextFieldConfigFromJson(json);

  /// Serializes this [TextFieldConfig] to JSON.
  Map<String, Object?> toJson() => _$TextFieldConfigToJson(this);
}

/// Describes how the input value should be transformed between
/// what the user sees and what is emitted/sent to business logic.
@freezed
@JsonSerializable()
class InputBehaviorConfig with _$InputBehaviorConfig {
  const InputBehaviorConfig({
    /// When `true`, prefixText is treated as part of the logical value
    /// (included in submitted/emitted data). When `false`, prefix is visual-only.
    this.includePrefixInData,
  });

  @override
  /// Whether [prefixText] should be included in the emitted value.
  final bool? includePrefixInData;

  factory InputBehaviorConfig.fromJson(Map<String, Object?> json) => _$InputBehaviorConfigFromJson(json);

  Map<String, Object?> toJson() => _$InputBehaviorConfigToJson(this);
}
