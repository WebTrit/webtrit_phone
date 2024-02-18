import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

import '../models/models.dart';

extension LoginTypeL10n on LoginType {
  String l10n(BuildContext context) {
    return switch (this) {
      LoginType.otpSignin => context.l10n.loginType_otpSignin,
      LoginType.passwordSignin => context.l10n.loginType_passwordSignin,
      LoginType.signup => context.l10n.loginType_signup,
    };
  }
}

extension LoginTypePageRouteInfo on LoginType {
  PageRouteInfo toPageRouteInfo() {
    return switch (this) {
      LoginType.otpSignin => const LoginOtpSigninRouterPageRoute(),
      LoginType.passwordSignin => const LoginPasswordSigninScreenPageRoute(),
      LoginType.signup => const LoginSignupRouterPageRoute(),
    };
  }
}
