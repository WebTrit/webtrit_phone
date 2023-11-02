import 'package:formz/formz.dart';
import 'package:validators/validators.dart';

enum EmailValidationError {
  blank,
  format,
}

class EmailInput extends FormzInput<String, EmailValidationError> {
  const EmailInput.pure([String value = '']) : super.pure(value);

  const EmailInput.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) {
      return EmailValidationError.blank;
    } else if (!isEmail(value)) {
      return EmailValidationError.format;
    } else {
      return null;
    }
  }
}
