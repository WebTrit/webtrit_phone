import 'package:flutter/material.dart';

class OutlinedButtonStyles extends ThemeExtension<OutlinedButtonStyles> {
  const OutlinedButtonStyles({
    required this.neutral,
  });

  final ButtonStyle? neutral;

  @override
  ThemeExtension<OutlinedButtonStyles> copyWith({
    ButtonStyle? neutral,
  }) {
    return OutlinedButtonStyles(
      neutral: neutral ?? this.neutral,
    );
  }

  @override
  ThemeExtension<OutlinedButtonStyles> lerp(ThemeExtension<OutlinedButtonStyles>? other, double t) {
    if (other is! OutlinedButtonStyles) {
      return this;
    }
    return OutlinedButtonStyles(
      neutral: ButtonStyle.lerp(neutral, other.neutral, t),
    );
  }
}
