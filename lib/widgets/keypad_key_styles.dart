import 'package:flutter/material.dart';

import 'keypad_key_style.dart';

class KeypadKeyStyles extends ThemeExtension<KeypadKeyStyles> {
  const KeypadKeyStyles({required this.primary});

  final KeypadKeyStyle? primary;

  @override
  KeypadKeyStyles copyWith({KeypadKeyStyle? primary}) {
    return KeypadKeyStyles(primary: primary ?? this.primary);
  }

  @override
  ThemeExtension<KeypadKeyStyles> lerp(
    ThemeExtension<KeypadKeyStyles>? other,
    double t,
  ) {
    if (other is! KeypadKeyStyles) return this;
    return KeypadKeyStyles(
      primary: KeypadKeyStyle.lerp(primary, other.primary, t),
    );
  }
}
