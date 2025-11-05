import 'package:formz/formz.dart';

enum CodeValidationError { blank }

class CodeInput extends FormzInput<String, CodeValidationError> {
  const CodeInput.pure([super.value = '']) : super.pure();

  const CodeInput.dirty([super.value = '']) : super.dirty();

  @override
  CodeValidationError? validator(String value) {
    if (value.isEmpty) {
      return CodeValidationError.blank;
    } else {
      return null;
    }
  }
}
