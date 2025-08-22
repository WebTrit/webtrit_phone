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
class InputDecorationConfig with _$InputDecorationConfig {
  @JsonSerializable(explicitToJson: true)
  const factory InputDecorationConfig({
    /// Text that suggests what sort of input the field accepts.
    String? hintText,

    /// Style to use for [hintText].
    TextStyleConfig? hintStyle,

    /// Optional label text displayed above the field when focused or filled.
    String? labelText,

    /// Style to use for [labelText].
    TextStyleConfig? labelStyle,

    /// Additional text displayed below the field (e.g. usage hints).
    String? helperText,

    /// Style to use for [helperText].
    TextStyleConfig? helperStyle,

    /// Style for validation error messages.
    TextStyleConfig? errorStyle,

    /// Optional fixed text placed before the input.
    String? prefixText,

    /// Style for [prefixText].
    TextStyleConfig? prefixStyle,

    /// Optional fixed text placed after the input.
    String? suffixText,

    /// Style for [suffixText].
    TextStyleConfig? suffixStyle,

    /// Background fill color (hex string, e.g. `#FFFFFF`).
    String? fillColor,

    /// Whether the field should be filled with [fillColor].
    bool? filled,

    /// Default border configuration for the field.
    BorderConfig? border,

    /// Border configuration when the field is enabled but unfocused.
    BorderConfig? enabledBorder,

    /// Border configuration when the field is focused.
    BorderConfig? focusedBorder,

    /// Border configuration when the field has an error.
    BorderConfig? errorBorder,

    /// Border configuration when focused and in error state.
    BorderConfig? focusedErrorBorder,

    /// Border configuration when the field is disabled.
    BorderConfig? disabledBorder,
  }) = _InputDecorationConfig;

  factory InputDecorationConfig.fromJson(Map<String, dynamic> json) => _$InputDecorationConfigFromJson(json);
}

/// Declarative configuration for input borders.
///
/// Mirrors Flutter’s [InputBorder] types such as [UnderlineInputBorder] and [OutlineInputBorder].
@freezed
class BorderConfig with _$BorderConfig {
  @JsonSerializable(explicitToJson: true)
  const factory BorderConfig({
    /// Border type: `'underline' | 'outline' | 'none'`.
    @Default('underline') String type,

    /// Corner radius for outline borders.
    double? borderRadius,

    /// Border color (hex string, e.g. `#000000`).
    String? borderColor,

    /// Stroke width of the border.
    double? borderWidth,
  }) = _BorderConfig;

  factory BorderConfig.fromJson(Map<String, dynamic> json) => _$BorderConfigFromJson(json);
}
