import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:webtrit_phone/theme/theme.dart';

import '../widgets/onboarding_picture_logo_style.dart';

class LoginModeSelectScreenStyle with Diagnosticable {
  LoginModeSelectScreenStyle({
    this.signInTypeButton,
    this.signUpTypeButton,
    this.systemUiOverlayStyle,
    this.onboardingPictureLogoStyle,
  });

  final ElevatedButtonStyleType? signInTypeButton;
  final ElevatedButtonStyleType? signUpTypeButton;
  final SystemUiOverlayStyle? systemUiOverlayStyle;
  final OnboardingPictureLogoStyle? onboardingPictureLogoStyle;

  static LoginModeSelectScreenStyle lerp(LoginModeSelectScreenStyle? a, LoginModeSelectScreenStyle? b, double t) {
    return LoginModeSelectScreenStyle(
      signInTypeButton: LerpTools.lerpButtonStyleType(a?.signInTypeButton, b?.signInTypeButton, t),
      signUpTypeButton: LerpTools.lerpButtonStyleType(a?.signUpTypeButton, b?.signUpTypeButton, t),
      systemUiOverlayStyle: b?.systemUiOverlayStyle ?? a?.systemUiOverlayStyle,
      onboardingPictureLogoStyle:
          OnboardingPictureLogoStyle.lerp(a?.onboardingPictureLogoStyle, b?.onboardingPictureLogoStyle, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ElevatedButtonStyleType?>('signInTypeButton', signInTypeButton));
    properties.add(DiagnosticsProperty<ElevatedButtonStyleType?>('signUpTypeButton', signUpTypeButton));
    properties.add(DiagnosticsProperty<SystemUiOverlayStyle?>('systemUiOverlayStyle', systemUiOverlayStyle));
    properties.add(
        DiagnosticsProperty<OnboardingPictureLogoStyle?>('onboardingPictureLogoStyle', onboardingPictureLogoStyle));
  }
}
