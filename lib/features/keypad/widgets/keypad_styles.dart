import 'package:flutter/material.dart';

import 'keypad_style.dart';

class KeypadStyles extends ThemeExtension<KeypadStyles> {
  const KeypadStyles({required this.primary});

  final KeypadStyle? primary;

  @override
  KeypadStyles copyWith({KeypadStyle? primary}) {
    return KeypadStyles(primary: primary ?? this.primary);
  }

  @override
  ThemeExtension<KeypadStyles> lerp(ThemeExtension<KeypadStyles>? other, double t) {
    if (other is! KeypadStyles) return this;
    return KeypadStyles(primary: KeypadStyle.lerp(primary, other.primary, t));
  }
}
