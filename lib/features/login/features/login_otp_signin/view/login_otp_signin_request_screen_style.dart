import 'package:flutter/foundation.dart';

import 'package:webtrit_phone/theme/styles/styles.dart';

class LoginOtpSigninPageStyle with Diagnosticable {
  const LoginOtpSigninPageStyle({this.refInput});

  final TextFieldStyle? refInput;

  LoginOtpSigninPageStyle copyWith({TextFieldStyle? refInput}) {
    return LoginOtpSigninPageStyle(refInput: refInput ?? this.refInput);
  }

  static LoginOtpSigninPageStyle? lerp(LoginOtpSigninPageStyle? a, LoginOtpSigninPageStyle? b, double t) {
    if (identical(a, b)) return a;
    return LoginOtpSigninPageStyle(refInput: TextFieldStyle.lerp(a?.refInput, b?.refInput, t));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextFieldStyle>('refInput', refInput));
  }
}
