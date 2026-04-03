import 'package:flutter/services.dart';

import 'package:webtrit_phone_number/webtrit_phone_number.dart';

class PhoneNormalizingFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final normalized = PhoneParser.normalize(newValue.text);
    if (normalized == newValue.text) return newValue;

    final prefix = newValue.text.substring(0, newValue.selection.baseOffset.clamp(0, newValue.text.length));
    final normalizedPrefix = PhoneParser.normalize(prefix);
    final newOffset = normalizedPrefix.length.clamp(0, normalized.length);

    return TextEditingValue(
      text: normalized,
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }
}
