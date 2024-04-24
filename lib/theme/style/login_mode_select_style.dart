import '../theme.dart';
import '../tools/tools.dart';

class LoginModeSelectStyle {
  LoginModeSelectStyle({
    this.signInTypeButton,
    this.signUpTypeButton,
  });

  final ElevatedButtonStyleType? signInTypeButton;
  final ElevatedButtonStyleType? signUpTypeButton;

  static LoginModeSelectStyle lerp(LoginModeSelectStyle? a, LoginModeSelectStyle? b, double t) {
    final newSignInButton = LerpTools.lerpButtonStyleType(a?.signInTypeButton, b?.signInTypeButton, t);
    final newSignUpButton = LerpTools.lerpButtonStyleType(a?.signUpTypeButton, b?.signUpTypeButton, t);
    return LoginModeSelectStyle(
      signInTypeButton: newSignInButton,
      signUpTypeButton: newSignUpButton,
    );
  }
}
