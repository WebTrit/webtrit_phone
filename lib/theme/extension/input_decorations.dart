import 'package:flutter/material.dart';

class InputDecorations extends ThemeExtension<InputDecorations> {
  const InputDecorations({
    required this.search,
    required this.keypad,
  });

  final InputDecoration? search;
  final InputDecoration? keypad;

  @override
  ThemeExtension<InputDecorations> copyWith({
    InputDecoration? search,
    InputDecoration? keypad,
  }) {
    return InputDecorations(
      search: search ?? this.search,
      keypad: keypad ?? this.keypad,
    );
  }

  @override
  ThemeExtension<InputDecorations> lerp(ThemeExtension<InputDecorations>? other, double t) {
    if (other is! InputDecorations) {
      return this;
    }
    return InputDecorations(
      search: t < 0.5 ? search : other.search,
      keypad: t < 0.5 ? keypad : other.keypad,
    );
  }
}
