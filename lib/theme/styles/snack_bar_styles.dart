import 'package:flutter/material.dart';

import 'snack_bar_style.dart';

class SnackBarStyles extends ThemeExtension<SnackBarStyles> {
  const SnackBarStyles({required this.primary});

  final SnackBarStyle? primary;

  @override
  ThemeExtension<SnackBarStyles> copyWith({SnackBarStyle? primary}) {
    return SnackBarStyles(primary: primary ?? this.primary);
  }

  @override
  ThemeExtension<SnackBarStyles> lerp(ThemeExtension<SnackBarStyles>? other, double t) {
    if (other == null || primary == null || other is! SnackBarStyles) {
      return this;
    }

    return SnackBarStyles(primary: SnackBarStyle.lerp(primary, other.primary, t));
  }
}
