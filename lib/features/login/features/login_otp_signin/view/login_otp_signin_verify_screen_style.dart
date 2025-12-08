import 'package:flutter/foundation.dart';

class LoginOtpSigninVerifyScreenStyle with Diagnosticable {
  const LoginOtpSigninVerifyScreenStyle({this.countdownRepeatInterval = const Duration(seconds: 30)});

  /// Countdown interval before the "Repeat" button becomes active.
  /// If [Duration.zero] -> countdown is disabled, button is always active.
  final Duration countdownRepeatInterval;

  LoginOtpSigninVerifyScreenStyle copyWith({Duration? countdownRepeatInterval}) {
    return LoginOtpSigninVerifyScreenStyle(
      countdownRepeatInterval: countdownRepeatInterval ?? this.countdownRepeatInterval,
    );
  }

  static LoginOtpSigninVerifyScreenStyle? lerp(
    LoginOtpSigninVerifyScreenStyle? a,
    LoginOtpSigninVerifyScreenStyle? b,
    double t,
  ) {
    if (identical(a, b)) return a;
    return LoginOtpSigninVerifyScreenStyle(
      countdownRepeatInterval: t < 0.5
          ? (a?.countdownRepeatInterval ?? const Duration(seconds: 30))
          : (b?.countdownRepeatInterval ?? const Duration(seconds: 30)),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Duration>('countdownRepeatInterval', countdownRepeatInterval));
  }
}
