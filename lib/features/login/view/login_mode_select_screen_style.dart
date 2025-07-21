import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:webtrit_phone/theme/theme.dart';

class LoginModeSelectScreenStyle with Diagnosticable {
  LoginModeSelectScreenStyle({
    this.signInTypeButton,
    this.signUpTypeButton,
    this.systemUiOverlayStyle,
  });

  final ElevatedButtonStyleType? signInTypeButton;
  final ElevatedButtonStyleType? signUpTypeButton;
  final SystemUiOverlayStyle? systemUiOverlayStyle;

  static LoginModeSelectScreenStyle lerp(LoginModeSelectScreenStyle? a, LoginModeSelectScreenStyle? b, double t) {
    return LoginModeSelectScreenStyle(
      signInTypeButton: LerpTools.lerpButtonStyleType(a?.signInTypeButton, b?.signInTypeButton, t),
      signUpTypeButton: LerpTools.lerpButtonStyleType(a?.signUpTypeButton, b?.signUpTypeButton, t),
      systemUiOverlayStyle: b?.systemUiOverlayStyle ?? a?.systemUiOverlayStyle,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ElevatedButtonStyleType?>('signInTypeButton', signInTypeButton));
    properties.add(DiagnosticsProperty<ElevatedButtonStyleType?>('signUpTypeButton', signUpTypeButton));
    properties.add(DiagnosticsProperty<SystemUiOverlayStyle?>('systemUiOverlayStyle', systemUiOverlayStyle));
  }
}
