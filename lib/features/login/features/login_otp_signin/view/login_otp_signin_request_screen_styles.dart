import 'package:flutter/material.dart';

import 'login_otp_signin_request_screen_style.dart';

class LoginOtpSigninPageStyles extends ThemeExtension<LoginOtpSigninPageStyles> {
  const LoginOtpSigninPageStyles({required this.primary});

  final LoginOtpSigninPageStyle? primary;

  @override
  ThemeExtension<LoginOtpSigninPageStyles> copyWith({LoginOtpSigninPageStyle? primary}) {
    return LoginOtpSigninPageStyles(primary: primary ?? this.primary);
  }

  @override
  ThemeExtension<LoginOtpSigninPageStyles> lerp(ThemeExtension<LoginOtpSigninPageStyles>? other, double t) {
    if (other is! LoginOtpSigninPageStyles) return this;

    return LoginOtpSigninPageStyles(primary: LoginOtpSigninPageStyle.lerp(primary, other.primary, t));
  }
}
