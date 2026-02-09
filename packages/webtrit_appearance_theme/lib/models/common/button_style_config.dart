import 'package:freezed_annotation/freezed_annotation.dart';

import 'geometry_config.dart';
import 'text_style_config.dart';

part 'button_style_config.freezed.dart';

part 'button_style_config.g.dart';

/// Represents a configurable button style used for UI theming.
/// Maps to Flutter's [ButtonStyle].
@freezed
@JsonSerializable(explicitToJson: true)
class ButtonStyleConfig with _$ButtonStyleConfig {
  const ButtonStyleConfig({
    /// The style for a button's text descendants.
    this.textStyle,

    /// The button's background fill color in hex format.
    this.backgroundColor,

    /// The color for the button's text/icon descendants in hex format.
    this.foregroundColor,

    /// The highlight color for states (focused, hovered, pressed) in hex format.
    this.overlayColor,

    /// The shadow color in hex format.
    this.shadowColor,

    /// The surface tint color in hex format.
    this.surfaceTintColor,

    /// The elevation of the button.
    this.elevation,

    /// The padding between the button's boundary and its child.
    this.padding,

    /// The minimum size of the button.
    this.minimumSize,

    /// The fixed size of the button.
    this.fixedSize,

    /// The maximum size of the button.
    this.maximumSize,

    /// The icon's color in hex format.
    this.iconColor,

    /// The icon's size.
    this.iconSize,

    /// The color and weight of the button's outline.
    this.side,

    /// The shape of the button (e.g., rounded corners).
    this.shape,

    /// Defines how compact the button's layout will be.
    this.visualDensity,

    /// The duration of animated changes in milliseconds.
    this.animationDuration,
  });

  /// The style for a button's text descendants.
  @override
  final TextStyleConfig? textStyle;

  /// The button's background fill color in hex format.
  @override
  final String? backgroundColor;

  /// The color for the button's text/icon descendants in hex format.
  @override
  final String? foregroundColor;

  /// The highlight color for states (focused, hovered, pressed) in hex format.
  @override
  final String? overlayColor;

  /// The shadow color in hex format.
  @override
  final String? shadowColor;

  /// The surface tint color in hex format.
  @override
  final String? surfaceTintColor;

  /// The elevation of the button.
  @override
  final double? elevation;

  /// The padding between the button's boundary and its child.
  @override
  final EdgeInsetsConfig? padding;

  /// The minimum size of the button.
  @override
  final SizeConfig? minimumSize;

  /// The fixed size of the button.
  @override
  final SizeConfig? fixedSize;

  /// The maximum size of the button.
  @override
  final SizeConfig? maximumSize;

  /// The icon's color in hex format.
  @override
  final String? iconColor;

  /// The icon's size.
  @override
  final double? iconSize;

  /// The color and weight of the button's outline.
  @override
  final BorderSideConfig? side;

  /// The shape of the button (e.g., rounded corners).
  @override
  final ShapeBorderConfig? shape;

  /// Defines how compact the button's layout will be.
  @override
  final VisualDensityConfig? visualDensity;

  /// The duration of animated changes in milliseconds.
  @override
  final int? animationDuration;

  factory ButtonStyleConfig.fromJson(Map<String, Object?> json) => _$ButtonStyleConfigFromJson(json);

  Map<String, Object?> toJson() => _$ButtonStyleConfigToJson(this);
}
