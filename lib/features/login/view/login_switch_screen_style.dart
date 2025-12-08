import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../widgets/onboarding_logo_style.dart';

class LoginSwitchScreenStyle with Diagnosticable {
  LoginSwitchScreenStyle({this.systemUiOverlayStyle, this.onboardingLogoStyle});

  final SystemUiOverlayStyle? systemUiOverlayStyle;
  final OnboardingLogoStyle? onboardingLogoStyle;

  static LoginSwitchScreenStyle lerp(LoginSwitchScreenStyle? a, LoginSwitchScreenStyle? b, double t) {
    return LoginSwitchScreenStyle(
      systemUiOverlayStyle: b?.systemUiOverlayStyle ?? a?.systemUiOverlayStyle,
      onboardingLogoStyle: OnboardingLogoStyle.lerp(a?.onboardingLogoStyle, b?.onboardingLogoStyle, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<SystemUiOverlayStyle?>('systemUiOverlayStyle', systemUiOverlayStyle));
    properties.add(DiagnosticsProperty<OnboardingLogoStyle?>('onboardingLogoStyle', onboardingLogoStyle));
  }
}
