import 'package:formz/formz.dart';
import 'package:validators/validators.dart';

enum UrlValidationError {
  blank,
  format,
}

class UrlInput extends FormzInput<String, UrlValidationError> {
  const UrlInput.pure([String value = '']) : super.pure(value);

  const UrlInput.dirty([String value = '']) : super.dirty(value);

  @override
  UrlValidationError? validator(String value) {
    if (value.isEmpty) {
      return UrlValidationError.blank;
    } else if (!isURL(
      value,
      protocols: ['https'],
      requireProtocol: false,
    )) {
      return UrlValidationError.format;
    } else {
      return null;
    }
  }
}
