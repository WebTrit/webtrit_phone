import 'package:formz/formz.dart';
import 'package:validators/validators.dart';

enum EmailValidationError {
  blank,
  format,
}

class EmailInput extends FormzInput<String, EmailValidationError> {
  const EmailInput.pure([super.value = '']) : super.pure();

  const EmailInput.dirty([super.value = '']) : super.dirty();

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
