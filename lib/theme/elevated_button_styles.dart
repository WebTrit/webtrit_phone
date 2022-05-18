import 'package:flutter/material.dart';

class ElevatedButtonStyles extends ThemeExtension<ElevatedButtonStyles> {
  const ElevatedButtonStyles({
    required this.primary,
    required this.neutral,
  });

  final ButtonStyle? primary;
  final ButtonStyle? neutral;

  @override
  ThemeExtension<ElevatedButtonStyles> copyWith({
    ButtonStyle? primary,
    ButtonStyle? neutral,
  }) {
    return ElevatedButtonStyles(
      primary: primary ?? this.primary,
      neutral: neutral ?? this.neutral,
    );
  }

  @override
  ThemeExtension<ElevatedButtonStyles> lerp(ThemeExtension<ElevatedButtonStyles>? other, double t) {
    if (other is! ElevatedButtonStyles) {
      return this;
    }
    return ElevatedButtonStyles(
      primary: ButtonStyle.lerp(primary, other.primary, t),
      neutral: ButtonStyle.lerp(neutral, other.neutral, t),
    );
  }
}
