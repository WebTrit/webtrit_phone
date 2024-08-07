import 'package:flutter/material.dart';

import '../models/models.dart';

class ElevatedButtonStyles extends ThemeExtension<ElevatedButtonStyles> {
  const ElevatedButtonStyles({
    required this.primary,
    required this.neutral,
    required this.primaryOnDark,
    required this.neutralOnDark,
  });

  final ButtonStyle? primary;
  final ButtonStyle? neutral;
  final ButtonStyle? primaryOnDark;
  final ButtonStyle? neutralOnDark;

  @override
  ThemeExtension<ElevatedButtonStyles> copyWith({
    ButtonStyle? primary,
    ButtonStyle? neutral,
    ButtonStyle? primaryOnDark,
    ButtonStyle? neutralOnDark,
  }) {
    return ElevatedButtonStyles(
      primary: primary ?? this.primary,
      neutral: neutral ?? this.neutral,
      primaryOnDark: primaryOnDark ?? this.primaryOnDark,
      neutralOnDark: neutralOnDark ?? this.neutralOnDark,
    );
  }

  ButtonStyle? getStyle(ElevatedButtonStyleType? type) {
    switch (type) {
      case ElevatedButtonStyleType.primary:
        return primary;
      case ElevatedButtonStyleType.neutral:
        return neutral;
      case ElevatedButtonStyleType.primaryOnDark:
        return primaryOnDark;
      case ElevatedButtonStyleType.neutralOnDark:
        return neutralOnDark;
      case null:
        return primary;
    }
  }

  @override
  ThemeExtension<ElevatedButtonStyles> lerp(ThemeExtension<ElevatedButtonStyles>? other, double t) {
    if (other is! ElevatedButtonStyles) {
      return this;
    }
    return ElevatedButtonStyles(
      primary: ButtonStyle.lerp(primary, other.primary, t),
      neutral: ButtonStyle.lerp(neutral, other.neutral, t),
      primaryOnDark: ButtonStyle.lerp(primaryOnDark, other.primaryOnDark, t),
      neutralOnDark: ButtonStyle.lerp(neutralOnDark, other.neutralOnDark, t),
    );
  }
}
