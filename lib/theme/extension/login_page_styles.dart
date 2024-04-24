import 'package:flutter/material.dart';

import '../style/style.dart';

class LoginPageStyles extends ThemeExtension<LoginPageStyles> {
  const LoginPageStyles({
    required this.primary,
  });

  final LoginModeSelectStyle? primary;

  @override
  ThemeExtension<LoginPageStyles> copyWith({
    LoginModeSelectStyle? primary,
  }) {
    return LoginPageStyles(
      primary: primary ?? this.primary,
    );
  }

  @override
  ThemeExtension<LoginPageStyles> lerp(ThemeExtension<LoginPageStyles>? other, double t) {
    if (other == null || primary == null || other is! LoginPageStyles) {
      return this;
    }

    return LoginPageStyles(primary: LoginModeSelectStyle.lerp(primary, other.primary, t));
  }
}
