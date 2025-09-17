import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/models.dart';
import 'package:webtrit_phone/features/features.dart';

import '../theme_style_factory.dart';

/// Builds [LoginSignupVerifyScreenStyles] from declarative page config.
///
/// Maps:
/// - [LoginSignupVerifyScreenPageConfig.countdownRepeatIntervalSeconds]
///   -> [LoginSignupVerifyScreenStyle.countdownRepeatInterval]
class LoginSignupVerifyScreenStyleFactory implements ThemeStyleFactory<LoginSignupVerifyScreenStyles> {
  LoginSignupVerifyScreenStyleFactory(
    this.colors,
    this.pageConfig,
  );

  final ColorScheme colors;

  /// Declarative config for Sign-Up verify screen.
  final LoginSignupVerifyScreenPageConfig? pageConfig;

  @override
  LoginSignupVerifyScreenStyles create() {
    // Default to 30 seconds if config is absent (preserve existing behavior).
    final seconds = pageConfig?.countdownRepeatIntervalSeconds ?? 30;

    // Guard against negatives; Duration.zero disables countdown.
    final countdownRepeatInterval = seconds <= 0 ? Duration.zero : Duration(seconds: seconds);

    return LoginSignupVerifyScreenStyles(
      primary: LoginSignupVerifyScreenStyle(
        countdownRepeatInterval: countdownRepeatInterval,
      ),
    );
  }
}
