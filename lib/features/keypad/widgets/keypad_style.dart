import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webtrit_phone/widgets/keypad_key_style.dart';

class KeypadStyle with Diagnosticable {
  const KeypadStyle({this.buttonStyle, this.keyStyle});

  final ButtonStyle? buttonStyle;
  final KeypadKeyStyle? keyStyle;

  KeypadStyle copyWith({ButtonStyle? buttonStyle, KeypadKeyStyle? keyStyle}) {
    return KeypadStyle(buttonStyle: buttonStyle ?? this.buttonStyle, keyStyle: keyStyle ?? this.keyStyle);
  }

  static KeypadStyle merge(KeypadStyle? a, KeypadStyle? b) {
    if (a == null) return b ?? const KeypadStyle();
    if (b == null) return a;
    return KeypadStyle(
      buttonStyle: _mergeButtonStyles(a.buttonStyle, b.buttonStyle),
      keyStyle: KeypadKeyStyle.merge(a.keyStyle, b.keyStyle),
    );
  }

  static ButtonStyle? _mergeButtonStyles(ButtonStyle? a, ButtonStyle? b) {
    if (a == null) return b;
    if (b == null) return a;
    return a.merge(b);
  }

  static KeypadStyle lerp(KeypadStyle? a, KeypadStyle? b, double t) {
    return KeypadStyle(
      buttonStyle: ButtonStyle.lerp(a?.buttonStyle, b?.buttonStyle, t),
      keyStyle: KeypadKeyStyle.lerp(a?.keyStyle, b?.keyStyle, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ButtonStyle?>('buttonStyle', buttonStyle))
      ..add(DiagnosticsProperty<KeypadKeyStyle?>('keyStyle', keyStyle));
  }
}
