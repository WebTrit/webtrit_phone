import 'package:flutter/foundation.dart';

class LoginSignupVerifyScreenStyle with Diagnosticable {
  const LoginSignupVerifyScreenStyle({
    this.countdownRepeatInterval = const Duration(seconds: 30),
  });

  /// Countdown interval before the "Repeat" button becomes active.
  /// If [Duration.zero] -> countdown is disabled, button is always active.
  final Duration countdownRepeatInterval;

  LoginSignupVerifyScreenStyle copyWith({
    Duration? countdownRepeatInterval,
  }) {
    return LoginSignupVerifyScreenStyle(
      countdownRepeatInterval: countdownRepeatInterval ?? this.countdownRepeatInterval,
    );
  }

  static LoginSignupVerifyScreenStyle? lerp(
    LoginSignupVerifyScreenStyle? a,
    LoginSignupVerifyScreenStyle? b,
    double t,
  ) {
    if (identical(a, b)) return a;
    return LoginSignupVerifyScreenStyle(
      countdownRepeatInterval: t < 0.5
          ? (a?.countdownRepeatInterval ?? const Duration(seconds: 30))
          : (b?.countdownRepeatInterval ?? const Duration(seconds: 30)),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Duration>(
      'countdownRepeatInterval',
      countdownRepeatInterval,
    ));
  }
}
