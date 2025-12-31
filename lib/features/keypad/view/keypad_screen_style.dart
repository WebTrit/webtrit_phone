import 'package:flutter/foundation.dart';

import 'package:webtrit_phone/theme/theme.dart';

import '../widgets/actionpad_style.dart';
import '../widgets/keypad_style.dart';

/// Defines the visual styling for the keypad screen.
///
/// This style extends [BaseScreenStyle] to include specific configurations
/// for the keypad's input fields, numeric grid, and action buttons.
class KeypadScreenStyle extends BaseScreenStyle with Diagnosticable {
  /// Creates a keypad screen style.
  const KeypadScreenStyle({
    super.background,
    this.inputField,
    this.contactNameField,
    this.keypadStyle,
    this.actionpadStyle,
  });

  /// The style for the main text input field (e.g., dialed number).
  final TextFieldStyle? inputField;

  /// The style for the contact name field, often shown when the dialed number matches a contact.
  final TextFieldStyle? contactNameField;

  /// The visual style for the numeric keypad grid.
  final KeypadStyle? keypadStyle;

  /// The visual style for the action pad (e.g., call button, backspace).
  final ActionpadStyle? actionpadStyle;

  /// Creates a copy of this style with the given fields replaced with the new values.
  KeypadScreenStyle copyWith({
    BackgroundStyle? background,
    TextFieldStyle? inputField,
    TextFieldStyle? contactNameField,
    KeypadStyle? keypadStyle,
    ActionpadStyle? actionpadStyle,
  }) {
    return KeypadScreenStyle(
      background: background ?? this.background,
      inputField: inputField ?? this.inputField,
      contactNameField: contactNameField ?? this.contactNameField,
      keypadStyle: keypadStyle ?? this.keypadStyle,
      actionpadStyle: actionpadStyle ?? this.actionpadStyle,
    );
  }

  /// Creates a copy of [KeypadScreenStyle] where values from [b] take precedence over [a].
  static KeypadScreenStyle merge(KeypadScreenStyle? a, KeypadScreenStyle? b) {
    if (a == null) return b ?? const KeypadScreenStyle();
    if (b == null) return a;

    return KeypadScreenStyle(
      background: b.background ?? a.background,
      inputField: TextFieldStyle.merge(a.inputField, b.inputField),
      contactNameField: TextFieldStyle.merge(a.contactNameField, b.contactNameField),
      keypadStyle: KeypadStyle.merge(a.keypadStyle, b.keypadStyle),
      actionpadStyle: ActionpadStyle.merge(a.actionpadStyle, b.actionpadStyle),
    );
  }

  /// Linearly interpolates between two [KeypadScreenStyle]s.
  static KeypadScreenStyle lerp(KeypadScreenStyle? a, KeypadScreenStyle? b, double t) {
    return KeypadScreenStyle(
      background: BaseScreenStyle.lerp(a?.background, b?.background, t),
      inputField: TextFieldStyle.lerp(a?.inputField, b?.inputField, t),
      contactNameField: TextFieldStyle.lerp(a?.contactNameField, b?.contactNameField, t),
      keypadStyle: KeypadStyle.lerp(a?.keypadStyle, b?.keypadStyle, t),
      actionpadStyle: ActionpadStyle.lerp(a?.actionpadStyle, b?.actionpadStyle, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<BackgroundStyle?>('background', background))
      ..add(DiagnosticsProperty<TextFieldStyle?>('inputField', inputField))
      ..add(DiagnosticsProperty<TextFieldStyle?>('contactNameField', contactNameField))
      ..add(DiagnosticsProperty<KeypadStyle?>('keypadStyle', keypadStyle))
      ..add(DiagnosticsProperty<ActionpadStyle?>('actionpadStyle', actionpadStyle));
  }
}
