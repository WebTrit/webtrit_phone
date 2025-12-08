import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/models.dart';
import 'package:webtrit_phone/features/features.dart';

import '../theme_style_factory.dart';

class LoginOtpSigninVerifyScreenStyleFactory implements ThemeStyleFactory<LoginOtpSigninVerifyScreenStyles> {
  LoginOtpSigninVerifyScreenStyleFactory(this.colors, this.pageConfig);

  /// Active color palette for resolving defaults/additional styling in future.
  final ColorScheme colors;

  /// Declarative config for OTP verify screen.
  final LoginOtpSigninVerifyScreenPageConfig? pageConfig;

  @override
  LoginOtpSigninVerifyScreenStyles create() {
    // Default to 30 seconds if config is absent (preserve existing behavior).
    final seconds = pageConfig?.countdownRepeatIntervalSeconds ?? 30;

    // Guard against negatives; 0 disables countdown.
    final countdownRepeatInterval = seconds <= 0 ? Duration.zero : Duration(seconds: seconds);

    return LoginOtpSigninVerifyScreenStyles(
      primary: LoginOtpSigninVerifyScreenStyle(countdownRepeatInterval: countdownRepeatInterval),
    );
  }
}
