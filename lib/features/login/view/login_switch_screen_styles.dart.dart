import 'package:flutter/material.dart';

import 'login_switch_screen_style.dart';

class LoginSwitchScreenStyles extends ThemeExtension<LoginSwitchScreenStyles> {
  const LoginSwitchScreenStyles({required this.primary});

  final LoginSwitchScreenStyle? primary;

  @override
  ThemeExtension<LoginSwitchScreenStyles> copyWith({LoginSwitchScreenStyle? primary}) {
    return LoginSwitchScreenStyles(primary: primary ?? this.primary);
  }

  @override
  ThemeExtension<LoginSwitchScreenStyles> lerp(ThemeExtension<LoginSwitchScreenStyles>? other, double t) {
    if (other == null || primary == null || other is! LoginSwitchScreenStyles) {
      return this;
    }

    return LoginSwitchScreenStyles(primary: LoginSwitchScreenStyle.lerp(primary, other.primary, t));
  }
}
