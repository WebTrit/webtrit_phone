import 'package:formz/formz.dart';

enum UserRefValidationError {
  blank,
  format,
}

class UserRefInput extends FormzInput<String, UserRefValidationError> {
  const UserRefInput.pure([super.value = '']) : super.pure();

  const UserRefInput.dirty([super.value = '']) : super.dirty();

  @override
  UserRefValidationError? validator(String value) {
    if (value.isEmpty) {
      return UserRefValidationError.blank;
    } else if (value.trim().isEmpty) {
      return UserRefValidationError.format;
    } else {
      return null;
    }
  }
}
