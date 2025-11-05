import 'package:freezed_annotation/freezed_annotation.dart';

import 'text_style_config.dart';

part 'keypad_style_config.freezed.dart';

part 'keypad_style_config.g.dart';

/// Declarative style configuration for the custom numeric keypad.
///
/// This model mirrors the visual aspects used by the app’s
/// [`Keypad` widget](https://github.com/WebTrit/webtrit_phone/blob/main/lib/features/keypad/widgets/keypad.dart),
/// allowing you to define typography and layout (spacing/padding) via JSON.
///
/// Typical usage:
///  - `textStyle` controls the main digit text (e.g. "1", "2", "3").
///  - `subtextStyle` controls the secondary label under the digit (e.g. letters).
///  - `spacing` defines the gap between keypad buttons (in logical pixels).
///  - `padding` defines the inner padding of each keypad button (in logical pixels).
@freezed
@JsonSerializable(explicitToJson: true)
class KeypadStyleConfig with _$KeypadStyleConfig {
  const KeypadStyleConfig({
    /// Text style for the primary digit label on each key.
    this.textStyle,

    /// Text style for the secondary/subtext label under the digit.
    this.subtextStyle,

    /// Spacing between keys, in logical pixels (dp).
    this.spacing,

    /// Inner padding applied to each key, in logical pixels (dp).
    this.padding,
  });

  @override
  final TextStyleConfig? textStyle;

  @override
  final TextStyleConfig? subtextStyle;

  @override
  final double? spacing;

  @override
  final double? padding;

  factory KeypadStyleConfig.fromJson(Map<String, dynamic> json) =>
      _$KeypadStyleConfigFromJson(json);

  Map<String, dynamic> toJson() => _$KeypadStyleConfigToJson(this);
}
