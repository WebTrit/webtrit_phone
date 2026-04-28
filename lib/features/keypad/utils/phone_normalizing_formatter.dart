import 'package:flutter/services.dart';

import 'package:webtrit_phone_number/webtrit_phone_number.dart';

class PhoneNormalizingFormatter extends TextInputFormatter {
  static final _nonDialableChars = RegExp(r'[^0-9*#+]');

  static String sanitize(String input) => PhoneParser.normalize(input).replaceAll(_nonDialableChars, '');

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final sanitized = sanitize(newValue.text);
    if (sanitized == newValue.text) return newValue;

    return TextEditingValue(
      text: sanitized,
      selection: TextSelection(
        baseOffset: _translateOffset(newValue.text, newValue.selection.baseOffset, sanitized.length),
        extentOffset: _translateOffset(newValue.text, newValue.selection.extentOffset, sanitized.length),
        affinity: newValue.selection.affinity,
        isDirectional: newValue.selection.isDirectional,
      ),
    );
  }

  int _translateOffset(String originalText, int offset, int sanitizedLength) {
    if (offset < 0) return offset;
    final prefix = originalText.substring(0, offset.clamp(0, originalText.length));
    final sanitizedPrefix = sanitize(prefix);
    return sanitizedPrefix.length.clamp(0, sanitizedLength);
  }
}
