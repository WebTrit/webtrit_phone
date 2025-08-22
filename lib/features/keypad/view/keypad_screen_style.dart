import 'package:flutter/foundation.dart';

import 'package:webtrit_phone/theme/styles/text_field_style.dart';

import '../widgets/actionpad_style.dart';
import '../widgets/keypad_style.dart';

class KeypadScreenStyle with Diagnosticable {
  const KeypadScreenStyle({
    this.inputField,
    this.contactNameField,
    this.keypadStyle,
    this.actionpadStyle,
    this.style,
  });

  final TextFieldStyle? inputField;

  final TextFieldStyle? contactNameField;

  final KeypadStyle? keypadStyle;

  final ActionpadStyle? actionpadStyle;

  final ActionpadStyle? style;

  ActionpadStyle? get resolvedActionpadStyle => ActionpadStyle.merge(actionpadStyle, style);

  KeypadScreenStyle copyWith({
    TextFieldStyle? inputField,
    TextFieldStyle? contactNameField,
    KeypadStyle? keypadStyle,
    ActionpadStyle? actionpadStyle,
    ActionpadStyle? style,
  }) {
    return KeypadScreenStyle(
      inputField: inputField ?? this.inputField,
      contactNameField: contactNameField ?? this.contactNameField,
      keypadStyle: keypadStyle ?? this.keypadStyle,
      actionpadStyle: actionpadStyle ?? this.actionpadStyle,
      style: style ?? this.style,
    );
  }

  static KeypadScreenStyle merge(KeypadScreenStyle? a, KeypadScreenStyle? b) {
    if (a == null) return b ?? const KeypadScreenStyle();
    if (b == null) return a;
    return KeypadScreenStyle(
      inputField: TextFieldStyle.merge(a.inputField, b.inputField),
      contactNameField: TextFieldStyle.merge(a.contactNameField, b.contactNameField),
      keypadStyle: KeypadStyle.merge(a.keypadStyle, b.keypadStyle),
      actionpadStyle: ActionpadStyle.merge(a.actionpadStyle, b.actionpadStyle),
      style: ActionpadStyle.merge(a.style, b.style),
    );
  }

  static KeypadScreenStyle lerp(KeypadScreenStyle? a, KeypadScreenStyle? b, double t) {
    return KeypadScreenStyle(
      inputField: TextFieldStyle.lerp(a?.inputField, b?.inputField, t),
      contactNameField: TextFieldStyle.lerp(a?.contactNameField, b?.contactNameField, t),
      keypadStyle: KeypadStyle.lerp(a?.keypadStyle, b?.keypadStyle, t),
      actionpadStyle: ActionpadStyle.lerp(a?.actionpadStyle, b?.actionpadStyle, t),
      style: ActionpadStyle.lerp(a?.style, b?.style, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<TextFieldStyle?>('inputField', inputField))
      ..add(DiagnosticsProperty<TextFieldStyle?>('contactNameField', contactNameField))
      ..add(DiagnosticsProperty<KeypadStyle?>('keypadStyle', keypadStyle))
      ..add(DiagnosticsProperty<ActionpadStyle?>('actionpadStyle', actionpadStyle))
      ..add(DiagnosticsProperty<ActionpadStyle?>('style', style))
      ..add(DiagnosticsProperty<ActionpadStyle?>('resolvedActionpadStyle', resolvedActionpadStyle));
  }
}
