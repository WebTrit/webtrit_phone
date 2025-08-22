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
class KeypadStyleConfig with _$KeypadStyleConfig {
  @JsonSerializable(explicitToJson: true)
  const factory KeypadStyleConfig({
    /// Text style for the primary digit label on each key.
    TextStyleConfig? textStyle,

    /// Text style for the secondary/subtext label under the digit.
    TextStyleConfig? subtextStyle,

    /// Spacing between keys, in logical pixels (dp).
    double? spacing,

    /// Inner padding applied to each key, in logical pixels (dp).
    double? padding,
  }) = _KeypadStyleConfig;

  factory KeypadStyleConfig.fromJson(Map<String, dynamic> json) => _$KeypadStyleConfigFromJson(json);
}
