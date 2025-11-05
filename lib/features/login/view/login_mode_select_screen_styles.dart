import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/login/view/login_mode_select_screen_style.dart';

class LoginModeSelectScreenStyles extends ThemeExtension<LoginModeSelectScreenStyles> {
  const LoginModeSelectScreenStyles({required this.primary});

  final LoginModeSelectScreenStyle? primary;

  @override
  ThemeExtension<LoginModeSelectScreenStyles> copyWith({LoginModeSelectScreenStyle? primary}) {
    return LoginModeSelectScreenStyles(primary: primary ?? this.primary);
  }

  @override
  ThemeExtension<LoginModeSelectScreenStyles> lerp(ThemeExtension<LoginModeSelectScreenStyles>? other, double t) {
    if (other == null || primary == null || other is! LoginModeSelectScreenStyles) {
      return this;
    }

    return LoginModeSelectScreenStyles(primary: LoginModeSelectScreenStyle.lerp(primary, other.primary, t));
  }
}
