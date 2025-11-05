import 'package:flutter/material.dart';
import 'keypad_screen_style.dart';

class KeypadScreenStyles extends ThemeExtension<KeypadScreenStyles> {
  const KeypadScreenStyles({required this.primary});

  final KeypadScreenStyle? primary;

  @override
  KeypadScreenStyles copyWith({KeypadScreenStyle? primary}) {
    return KeypadScreenStyles(primary: primary ?? this.primary);
  }

  @override
  ThemeExtension<KeypadScreenStyles> lerp(ThemeExtension<KeypadScreenStyles>? other, double t) {
    if (other is! KeypadScreenStyles) return this;
    return KeypadScreenStyles(primary: KeypadScreenStyle.lerp(primary, other.primary, t));
  }
}
