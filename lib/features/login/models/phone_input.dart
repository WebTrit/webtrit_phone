import 'package:formz/formz.dart';

enum PhoneValidationError {
  blank,
}

class PhoneInput extends FormzInput<String, PhoneValidationError> {
  const PhoneInput.pure([String value = '']) : super.pure(value);

  const PhoneInput.dirty([String value = '']) : super.dirty(value);

  @override
  PhoneValidationError? validator(String value) {
    if (value.isEmpty) {
      return PhoneValidationError.blank;
    } else {
      return null;
    }
  }
}
