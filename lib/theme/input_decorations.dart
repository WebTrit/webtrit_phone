import 'package:flutter/material.dart';

class InputDecorations extends ThemeExtension<InputDecorations> {
  const InputDecorations({
    required this.keypad,
  });

  final InputDecoration? keypad;

  @override
  ThemeExtension<InputDecorations> copyWith({
    InputDecoration? keypad,
  }) {
    return InputDecorations(
      keypad: keypad ?? this.keypad,
    );
  }

  @override
  ThemeExtension<InputDecorations> lerp(ThemeExtension<InputDecorations>? other, double t) {
    if (other is! InputDecorations) {
      return this;
    }
    return InputDecorations(
      keypad: t < 0.5 ? keypad : other.keypad,
    );
  }
}
