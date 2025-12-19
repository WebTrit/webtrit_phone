import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:webtrit_phone/theme/theme.dart';

class LoginModeSelectScreenStyle with Diagnosticable {
  LoginModeSelectScreenStyle({
    this.signInTypeButton,
    this.signUpTypeButton,
    this.systemUiOverlayStyle,
    this.pictureLogoStyle,
    this.onboardingTextStyle,
  });

  final ElevatedButtonStyleType? signInTypeButton;
  final ElevatedButtonStyleType? signUpTypeButton;
  final SystemUiOverlayStyle? systemUiOverlayStyle;
  final ThemeImageStyle? pictureLogoStyle;
  final TextStyle? onboardingTextStyle;

  static LoginModeSelectScreenStyle lerp(LoginModeSelectScreenStyle? a, LoginModeSelectScreenStyle? b, double t) {
    return LoginModeSelectScreenStyle(
      signInTypeButton: LerpTools.lerpButtonStyleType(a?.signInTypeButton, b?.signInTypeButton, t),
      signUpTypeButton: LerpTools.lerpButtonStyleType(a?.signUpTypeButton, b?.signUpTypeButton, t),
      systemUiOverlayStyle: b?.systemUiOverlayStyle ?? a?.systemUiOverlayStyle,
      pictureLogoStyle: ThemeImageStyle.lerp(a?.pictureLogoStyle, b?.pictureLogoStyle, t),
      onboardingTextStyle: TextStyle.lerp(a?.onboardingTextStyle, b?.onboardingTextStyle, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ElevatedButtonStyleType?>('signInTypeButton', signInTypeButton));
    properties.add(DiagnosticsProperty<ElevatedButtonStyleType?>('signUpTypeButton', signUpTypeButton));
    properties.add(DiagnosticsProperty<SystemUiOverlayStyle?>('systemUiOverlayStyle', systemUiOverlayStyle));
    properties.add(DiagnosticsProperty<ThemeImageStyle?>('pictureLogoStyle', pictureLogoStyle));
    properties.add(DiagnosticsProperty<TextStyle?>('onboardingTextStyle', onboardingTextStyle));
  }
}
