import 'package:flutter/material.dart';

class TextButtonStyles extends ThemeExtension<TextButtonStyles> {
  const TextButtonStyles({
    required this.neutral,
  });

  final ButtonStyle? neutral;

  @override
  ThemeExtension<TextButtonStyles> copyWith({
    ButtonStyle? neutral,
  }) {
    return TextButtonStyles(
      neutral: neutral ?? this.neutral,
    );
  }

  @override
  ThemeExtension<TextButtonStyles> lerp(ThemeExtension<TextButtonStyles>? other, double t) {
    if (other is! TextButtonStyles) {
      return this;
    }
    return TextButtonStyles(
      neutral: ButtonStyle.lerp(neutral, other.neutral, t),
    );
  }
}
