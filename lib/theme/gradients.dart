import 'package:flutter/material.dart';

class Gradients extends ThemeExtension<Gradients> {
  const Gradients({
    required this.tab,
  });

  final Gradient? tab;

  @override
  ThemeExtension<Gradients> copyWith({
    Gradient? tab,
  }) {
    return Gradients(
      tab: tab ?? this.tab,
    );
  }

  @override
  ThemeExtension<Gradients> lerp(ThemeExtension<Gradients>? other, double t) {
    if (other is! Gradients) {
      return this;
    }
    return Gradients(
      tab: Gradient.lerp(tab, other.tab, t),
    );
  }
}
