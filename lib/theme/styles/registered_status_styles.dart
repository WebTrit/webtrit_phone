import 'package:flutter/material.dart';

import 'registered_status_style.dart';

class RegisteredStatusStyles extends ThemeExtension<RegisteredStatusStyles> {
  const RegisteredStatusStyles({
    required this.primary,
  });

  final RegisteredStatusStyle primary;

  @override
  ThemeExtension<RegisteredStatusStyles> copyWith({
    RegisteredStatusStyle? primary,
  }) {
    return RegisteredStatusStyles(
      primary: primary ?? this.primary,
    );
  }

  @override
  ThemeExtension<RegisteredStatusStyles> lerp(ThemeExtension<RegisteredStatusStyles>? other, double t) {
    if (other == null || other is! RegisteredStatusStyles) {
      return this;
    }

    return RegisteredStatusStyles(primary: RegisteredStatusStyle.lerp(primary, other.primary, t));
  }
}
