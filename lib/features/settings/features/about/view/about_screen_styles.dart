import 'package:flutter/material.dart';

import 'about_screen_style.dart';

class AboutScreenStyles extends ThemeExtension<AboutScreenStyles> {
  const AboutScreenStyles({required this.primary});

  final AboutScreenStyle? primary;

  @override
  ThemeExtension<AboutScreenStyles> copyWith({AboutScreenStyle? primary}) {
    return AboutScreenStyles(primary: primary ?? this.primary);
  }

  @override
  ThemeExtension<AboutScreenStyles> lerp(ThemeExtension<AboutScreenStyles>? other, double t) {
    if (other == null || primary == null || other is! AboutScreenStyles) {
      return this;
    }

    return AboutScreenStyles(primary: AboutScreenStyle.lerp(primary, other.primary, t));
  }
}
