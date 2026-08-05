import 'package:flutter/material.dart';

import 'login_core_url_assign_screen_style.dart';

class LoginCoreUrlAssignScreenStyles extends ThemeExtension<LoginCoreUrlAssignScreenStyles> {
  const LoginCoreUrlAssignScreenStyles({required this.primary});

  final LoginCoreUrlAssignScreenStyle? primary;

  @override
  LoginCoreUrlAssignScreenStyles copyWith({LoginCoreUrlAssignScreenStyle? primary}) {
    return LoginCoreUrlAssignScreenStyles(primary: primary ?? this.primary);
  }

  @override
  ThemeExtension<LoginCoreUrlAssignScreenStyles> lerp(ThemeExtension<LoginCoreUrlAssignScreenStyles>? other, double t) {
    if (other is! LoginCoreUrlAssignScreenStyles) return this;
    return LoginCoreUrlAssignScreenStyles(primary: LoginCoreUrlAssignScreenStyle.lerp(primary, other.primary, t));
  }
}
