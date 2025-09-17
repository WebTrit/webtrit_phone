import 'package:flutter/material.dart';

import 'login_otp_signin_verify_screen_style.dart';

class LoginOtpSigninVerifyScreenStyles extends ThemeExtension<LoginOtpSigninVerifyScreenStyles> {
  const LoginOtpSigninVerifyScreenStyles({
    required this.primary,
  });

  final LoginOtpSigninVerifyScreenStyle? primary;

  @override
  ThemeExtension<LoginOtpSigninVerifyScreenStyles> copyWith({
    LoginOtpSigninVerifyScreenStyle? primary,
  }) {
    return LoginOtpSigninVerifyScreenStyles(
      primary: primary ?? this.primary,
    );
  }

  @override
  ThemeExtension<LoginOtpSigninVerifyScreenStyles> lerp(
    ThemeExtension<LoginOtpSigninVerifyScreenStyles>? other,
    double t,
  ) {
    if (other is! LoginOtpSigninVerifyScreenStyles) return this;

    return LoginOtpSigninVerifyScreenStyles(
      primary: LoginOtpSigninVerifyScreenStyle.lerp(primary, other.primary, t),
    );
  }
}
