import 'package:flutter/material.dart';

import 'embedded_screen_style.dart';

class EmbeddedScreenStyles extends ThemeExtension<EmbeddedScreenStyles> {
  const EmbeddedScreenStyles({required this.primary});

  final EmbeddedScreenStyle? primary;

  @override
  EmbeddedScreenStyles copyWith({EmbeddedScreenStyle? primary}) {
    return EmbeddedScreenStyles(primary: primary ?? this.primary);
  }

  @override
  ThemeExtension<EmbeddedScreenStyles> lerp(ThemeExtension<EmbeddedScreenStyles>? other, double t) {
    if (other is! EmbeddedScreenStyles) return this;
    return EmbeddedScreenStyles(primary: EmbeddedScreenStyle.lerp(primary, other.primary, t));
  }
}
