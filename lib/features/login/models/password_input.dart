import 'package:formz/formz.dart';

enum PasswordValidationError {
  blank,
}

class PasswordInput extends FormzInput<String, PasswordValidationError> {
  const PasswordInput.pure([String value = '']) : super.pure(value);

  const PasswordInput.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.blank;
    } else {
      return null;
    }
  }
}
