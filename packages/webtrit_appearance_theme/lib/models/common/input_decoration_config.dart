import 'package:freezed_annotation/freezed_annotation.dart';

import 'text_style_config.dart';

part 'input_decoration_config.freezed.dart';

part 'input_decoration_config.g.dart';

/// Declarative configuration for a [TextField]'s [InputDecoration].
///
/// This class mirrors the options available in Flutter’s
/// [InputDecoration](https://api.flutter.dev/flutter/material/InputDecoration-class.html)
/// and allows them to be expressed in JSON for dynamic theming or remote configuration.
///
/// See also:
/// - [Google Material Design – Text fields](https://m3.material.io/components/text-fields/overview)
@freezed
@JsonSerializable(explicitToJson: true)
class InputDecorationConfig with _$InputDecorationConfig {
  const InputDecorationConfig({
    /// Text that suggests what sort of input the field accepts.
    this.hintText,

    /// Style to use for [hintText].
    this.hintStyle,

    /// Optional label text displayed above the field when focused or filled.
    this.labelText,

    /// Style to use for [labelText].
    this.labelStyle,

    /// Additional text displayed below the field (e.g. usage hints).
    this.helperText,

    /// Style to use for [helperText].
    this.helperStyle,

    /// Style for validation error messages.
    this.errorStyle,

    /// Optional fixed text placed before the input.
    this.prefixText,

    /// Style for [prefixText].
    this.prefixStyle,

    /// Optional fixed text placed after the input.
    this.suffixText,

    /// Style for [suffixText].
    this.suffixStyle,

    /// Background fill color (hex string, e.g. `#FFFFFF`).
    this.fillColor,

    /// Whether the field should be filled with [fillColor].
    this.filled,

    /// Default border configuration for the field.
    this.border,

    /// Border configuration when the field is enabled but unfocused.
    this.enabledBorder,

    /// Border configuration when the field is focused.
    this.focusedBorder,

    /// Border configuration when the field has an error.
    this.errorBorder,

    /// Border configuration when focused and in error state.
    this.focusedErrorBorder,

    /// Border configuration when the field is disabled.
    this.disabledBorder,
  });

  @override
  final String? hintText;

  @override
  final TextStyleConfig? hintStyle;

  @override
  final String? labelText;

  @override
  final TextStyleConfig? labelStyle;

  @override
  final String? helperText;

  @override
  final TextStyleConfig? helperStyle;

  @override
  final TextStyleConfig? errorStyle;

  @override
  final String? prefixText;

  @override
  final TextStyleConfig? prefixStyle;

  @override
  final String? suffixText;

  @override
  final TextStyleConfig? suffixStyle;

  @override
  final String? fillColor;

  @override
  final bool? filled;

  @override
  final BorderConfig? border;

  @override
  final BorderConfig? enabledBorder;

  @override
  final BorderConfig? focusedBorder;

  @override
  final BorderConfig? errorBorder;

  @override
  final BorderConfig? focusedErrorBorder;

  @override
  final BorderConfig? disabledBorder;

  factory InputDecorationConfig.fromJson(Map<String, dynamic> json) => _$InputDecorationConfigFromJson(json);

  Map<String, dynamic> toJson() => _$InputDecorationConfigToJson(this);
}

/// Declarative configuration for input borders.
///
/// Mirrors Flutter’s [InputBorder] types such as [UnderlineInputBorder] and [OutlineInputBorder].
@freezed
@JsonSerializable(explicitToJson: true)
class BorderConfig with _$BorderConfig {
  const BorderConfig({
    /// Border type: `'underline' | 'outline' | 'none'`.
    this.type = 'underline',

    /// Corner radius for outline borders.
    this.borderRadius,

    /// Border color (hex string, e.g. `#000000`).
    this.borderColor,

    /// Stroke width of the border.
    this.borderWidth,
  });

  @override
  final String type;

  @override
  final double? borderRadius;

  @override
  final String? borderColor;

  @override
  final double? borderWidth;

  factory BorderConfig.fromJson(Map<String, dynamic> json) => _$BorderConfigFromJson(json);

  Map<String, dynamic> toJson() => _$BorderConfigToJson(this);
}
