import 'package:flutter/foundation.dart';

import 'package:formz/formz.dart';
import 'package:validators/validators.dart';

enum UrlValidationError {
  blank,
  format,
}

class UrlInput extends FormzInput<String, UrlValidationError> {
  const UrlInput.pure([super.value = '']) : super.pure();

  const UrlInput.dirty([super.value = '']) : super.dirty();

  @override
  UrlValidationError? validator(String value) {
    if (value.isEmpty) {
      return UrlValidationError.blank;
    } else if (!isURL(
      value,
      protocols: [
        'https',
        if (kDebugMode) 'http',
      ],
      requireProtocol: false,
    )) {
      return UrlValidationError.format;
    } else {
      return null;
    }
  }
}
