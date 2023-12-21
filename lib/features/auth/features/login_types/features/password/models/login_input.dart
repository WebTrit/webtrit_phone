import 'package:formz/formz.dart';

enum LoginValidationError {
  blank,
}

class LoginInput extends FormzInput<String, LoginValidationError> {
  const LoginInput.pure([super.value = '']) : super.pure();

  const LoginInput.dirty([super.value = '']) : super.dirty();

  @override
  LoginValidationError? validator(String value) {
    if (value.isEmpty) {
      return LoginValidationError.blank;
    } else {
      return null;
    }
  }
}
