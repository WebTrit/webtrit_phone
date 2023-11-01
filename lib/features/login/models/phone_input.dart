import 'package:formz/formz.dart';

enum PhoneValidationError {
  blank,
  format,
}

class PhoneInput extends FormzInput<String, PhoneValidationError> {
  const PhoneInput.pure([super.value = '']) : super.pure();

  const PhoneInput.dirty([super.value = '']) : super.dirty();

  @override
  PhoneValidationError? validator(String value) {
    if (value.isEmpty) {
      return PhoneValidationError.blank;
    } else if (value.trim().isEmpty) {
      return PhoneValidationError.format;
    } else {
      return null;
    }
  }
}
