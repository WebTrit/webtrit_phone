import 'package:formz/formz.dart';

enum UrlValidationError {
  blank,
}

class UrlInput extends FormzInput<String, UrlValidationError> {
  const UrlInput.pure([String value = '']) : super.pure(value);

  const UrlInput.dirty([String value = '']) : super.dirty(value);

  @override
  UrlValidationError? validator(String value) {
    if (value.isEmpty) {
      return UrlValidationError.blank;
    } else {
      return null;
    }
  }
}
