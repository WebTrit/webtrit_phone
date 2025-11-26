import 'package:flutter/foundation.dart';

import 'package:webtrit_phone/theme/styles/styles.dart';

class LoginPasswordSigninPageStyle with Diagnosticable {
  const LoginPasswordSigninPageStyle({this.refInput, this.passwordInput});

  final TextFieldStyle? refInput;
  final TextFieldStyle? passwordInput;

  LoginPasswordSigninPageStyle copyWith({TextFieldStyle? refInput, TextFieldStyle? passwordInput}) {
    return LoginPasswordSigninPageStyle(
      refInput: refInput ?? this.refInput,
      passwordInput: passwordInput ?? this.passwordInput,
    );
  }

  static LoginPasswordSigninPageStyle? lerp(
    LoginPasswordSigninPageStyle? a,
    LoginPasswordSigninPageStyle? b,
    double t,
  ) {
    if (identical(a, b)) return a;
    return LoginPasswordSigninPageStyle(
      refInput: TextFieldStyle.lerp(a?.refInput, b?.refInput, t),
      passwordInput: TextFieldStyle.lerp(a?.passwordInput, b?.passwordInput, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextFieldStyle>('refInput', refInput));
    properties.add(DiagnosticsProperty<TextFieldStyle>('passwordInput', passwordInput));
  }
}
