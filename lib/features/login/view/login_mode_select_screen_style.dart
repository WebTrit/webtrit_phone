import 'package:webtrit_phone/theme/theme.dart';

class LoginModeSelectScreenStyle {
  LoginModeSelectScreenStyle({
    this.signInTypeButton,
    this.signUpTypeButton,
  });

  final ElevatedButtonStyleType? signInTypeButton;
  final ElevatedButtonStyleType? signUpTypeButton;

  static LoginModeSelectScreenStyle lerp(LoginModeSelectScreenStyle? a, LoginModeSelectScreenStyle? b, double t) {
    final newSignInButton = LerpTools.lerpButtonStyleType(a?.signInTypeButton, b?.signInTypeButton, t);
    final newSignUpButton = LerpTools.lerpButtonStyleType(a?.signUpTypeButton, b?.signUpTypeButton, t);
    return LoginModeSelectScreenStyle(
      signInTypeButton: newSignInButton,
      signUpTypeButton: newSignUpButton,
    );
  }
}
