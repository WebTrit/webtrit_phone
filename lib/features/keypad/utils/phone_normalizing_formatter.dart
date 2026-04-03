import 'package:flutter/services.dart';

import 'package:webtrit_phone_number/webtrit_phone_number.dart';

class PhoneNormalizingFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final sanitized = PhoneParser.normalize(newValue.text).replaceAll(RegExp(r'[^0-9*#+]'), '');
    if (sanitized == newValue.text) return newValue;

    final prefix = newValue.text.substring(0, newValue.selection.baseOffset.clamp(0, newValue.text.length));
    final sanitizedPrefix = PhoneParser.normalize(prefix).replaceAll(RegExp(r'[^0-9*#+]'), '');
    final newOffset = sanitizedPrefix.length.clamp(0, sanitized.length);

    return TextEditingValue(
      text: sanitized,
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }
}
