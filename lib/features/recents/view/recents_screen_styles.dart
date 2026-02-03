import 'package:flutter/material.dart';

import 'recents_screen_style.dart';

class RecentsScreenStyles extends ThemeExtension<RecentsScreenStyles> {
  const RecentsScreenStyles({required this.primary});

  final RecentsScreenStyle? primary;

  @override
  RecentsScreenStyles copyWith({RecentsScreenStyle? primary}) {
    return RecentsScreenStyles(primary: primary ?? this.primary);
  }

  @override
  ThemeExtension<RecentsScreenStyles> lerp(ThemeExtension<RecentsScreenStyles>? other, double t) {
    if (other is! RecentsScreenStyles) return this;
    return RecentsScreenStyles(primary: RecentsScreenStyle.lerp(primary, other.primary, t));
  }
}
