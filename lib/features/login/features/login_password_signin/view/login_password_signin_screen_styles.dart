import 'package:flutter/material.dart';

import 'login_password_signin_screen_style.dart';

class LoginPasswordSigninPageStyles extends ThemeExtension<LoginPasswordSigninPageStyles> {
  const LoginPasswordSigninPageStyles({required this.primary});

  final LoginPasswordSigninPageStyle? primary;

  @override
  ThemeExtension<LoginPasswordSigninPageStyles> copyWith({LoginPasswordSigninPageStyle? primary}) {
    return LoginPasswordSigninPageStyles(primary: primary ?? this.primary);
  }

  @override
  ThemeExtension<LoginPasswordSigninPageStyles> lerp(ThemeExtension<LoginPasswordSigninPageStyles>? other, double t) {
    if (other is! LoginPasswordSigninPageStyles) return this;

    return LoginPasswordSigninPageStyles(primary: LoginPasswordSigninPageStyle.lerp(primary, other.primary, t));
  }
}
