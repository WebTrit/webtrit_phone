import 'package:flutter/material.dart';

class TextButtonStyles extends ThemeExtension<TextButtonStyles> {
  const TextButtonStyles({
    required this.neutral,
    required this.dangerous,
  });

  final ButtonStyle? neutral;
  final ButtonStyle? dangerous;

  @override
  ThemeExtension<TextButtonStyles> copyWith({
    ButtonStyle? neutral,
  }) {
    return TextButtonStyles(
      neutral: neutral ?? this.neutral,
      dangerous: dangerous ?? this.dangerous,
    );
  }

  @override
  ThemeExtension<TextButtonStyles> lerp(ThemeExtension<TextButtonStyles>? other, double t) {
    if (other is! TextButtonStyles) {
      return this;
    }
    return TextButtonStyles(
      neutral: ButtonStyle.lerp(neutral, other.neutral, t),
      dangerous: ButtonStyle.lerp(dangerous, other.dangerous, t),
    );
  }
}
