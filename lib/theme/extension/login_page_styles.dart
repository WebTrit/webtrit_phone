import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/login/view/login_mode_select_screen_style.dart';

class LoginPageStyles extends ThemeExtension<LoginPageStyles> {
  const LoginPageStyles({
    required this.primary,
  });

  final LoginModeSelectScreenStyle? primary;

  @override
  ThemeExtension<LoginPageStyles> copyWith({
    LoginModeSelectScreenStyle? primary,
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

    return LoginPageStyles(primary: LoginModeSelectScreenStyle.lerp(primary, other.primary, t));
  }
}
