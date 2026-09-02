import 'package:flutter/material.dart';

import 'number_cdrs_screen_style.dart';

class NumberCdrsScreenStyles extends ThemeExtension<NumberCdrsScreenStyles> {
  const NumberCdrsScreenStyles({required this.primary});

  final NumberCdrsScreenStyle? primary;

  @override
  NumberCdrsScreenStyles copyWith({NumberCdrsScreenStyle? primary}) {
    return NumberCdrsScreenStyles(primary: primary ?? this.primary);
  }

  @override
  ThemeExtension<NumberCdrsScreenStyles> lerp(ThemeExtension<NumberCdrsScreenStyles>? other, double t) {
    if (other is! NumberCdrsScreenStyles) return this;
    return NumberCdrsScreenStyles(primary: NumberCdrsScreenStyle.lerp(primary, other.primary, t));
  }
}
