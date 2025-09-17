import 'package:flutter/material.dart';

import 'login_signup_verify_screen_style.dart';

class LoginSignupVerifyScreenStyles
    extends ThemeExtension<LoginSignupVerifyScreenStyles> {
  const LoginSignupVerifyScreenStyles({
    required this.primary,
  });

  final LoginSignupVerifyScreenStyle? primary;

  @override
  ThemeExtension<LoginSignupVerifyScreenStyles> copyWith({
    LoginSignupVerifyScreenStyle? primary,
  }) {
    return LoginSignupVerifyScreenStyles(
      primary: primary ?? this.primary,
    );
  }

  @override
  ThemeExtension<LoginSignupVerifyScreenStyles> lerp(
      ThemeExtension<LoginSignupVerifyScreenStyles>? other,
      double t,
      ) {
    if (other is! LoginSignupVerifyScreenStyles) return this;
    return LoginSignupVerifyScreenStyles(
      primary: LoginSignupVerifyScreenStyle.lerp(primary, other.primary, t),
    );
  }
}
