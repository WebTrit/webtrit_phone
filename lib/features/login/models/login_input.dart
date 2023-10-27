import 'package:formz/formz.dart';

enum LoginValidationError {
  blank,
}

class LoginInput extends FormzInput<String, LoginValidationError> {
  const LoginInput.pure([String value = '']) : super.pure(value);

  const LoginInput.dirty([String value = '']) : super.dirty(value);

  @override
  LoginValidationError? validator(String value) {
    if (value.isEmpty) {
      return LoginValidationError.blank;
    } else {
      return null;
    }
  }
}
