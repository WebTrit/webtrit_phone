import 'package:formz/formz.dart';

enum CodeValidationError {
  blank,
}

class CodeInput extends FormzInput<String, CodeValidationError> {
  const CodeInput.pure([String value = '']) : super.pure(value);

  const CodeInput.dirty([String value = '']) : super.dirty(value);

  @override
  CodeValidationError? validator(String value) {
    if (value.isEmpty) {
      return CodeValidationError.blank;
    } else {
      return null;
    }
  }
}
