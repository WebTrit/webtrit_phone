import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/keypad/utils/utils.dart';

TextEditingValue _val(String text, {int? base, int? extent}) {
  final b = base ?? text.length;
  final e = extent ?? b;
  return TextEditingValue(
    text: text,
    selection: TextSelection(baseOffset: b, extentOffset: e),
  );
}

void main() {
  final formatter = PhoneNormalizingFormatter();

  TextEditingValue format(TextEditingValue newValue) => formatter.formatEditUpdate(TextEditingValue.empty, newValue);

  group('PhoneNormalizingFormatter.sanitize', () {
    test('keeps digits, *, #, +', () {
      expect(PhoneNormalizingFormatter.sanitize('+380671234567'), '+380671234567');
      expect(PhoneNormalizingFormatter.sanitize('*21#'), '*21#');
    });

    test('strips spaces and formatting characters', () {
      expect(PhoneNormalizingFormatter.sanitize('+380 (67) 123-45-67'), '+380671234567');
    });

    test('strips non-dialable characters', () {
      expect(PhoneNormalizingFormatter.sanitize('*"{'), '*');
      expect(PhoneNormalizingFormatter.sanitize('abc123'), '123');
    });

    test('normalizes Unicode lookalike digits', () {
      // Mathematical bold digits 𝟎–𝟗 → 0–9
      expect(PhoneNormalizingFormatter.sanitize('𝟏𝟐𝟑'), '123');
    });

    test('returns empty string for all-invalid input', () {
      expect(PhoneNormalizingFormatter.sanitize('abc!@\$'), '');
    });
  });

  group('PhoneNormalizingFormatter.formatEditUpdate', () {
    test('returns newValue unchanged when no sanitization needed', () {
      final value = _val('+380671234567');
      expect(format(value), value);
    });

    test('strips spaces on paste', () {
      final result = format(_val('+380 67 123'));
      expect(result.text, '+38067123');
    });

    test('strips non-dialable characters on paste', () {
      final result = format(_val('*"{'));
      expect(result.text, '*');
    });

    test('cursor moves to end when characters before it are removed', () {
      // Input: '1 2 3', cursor after the space at index 2 → '12', cursor at 2
      final result = format(_val('1 2 3', base: 2));
      expect(result.text, '123');
      expect(result.selection.baseOffset, 1); // only '1' before the space
    });

    test('cursor stays in place when only trailing chars are removed', () {
      // Input: '123abc', cursor at 3 (after '3')
      final result = format(_val('123abc', base: 3));
      expect(result.text, '123');
      expect(result.selection.baseOffset, 3);
    });

    test('preserves selection range (base != extent)', () {
      // Input: '1 2 3', select from 0 to 3 (covers '1 2')
      final result = format(_val('1 2 3', base: 0, extent: 3));
      expect(result.text, '123');
      expect(result.selection.baseOffset, 0);
      expect(result.selection.extentOffset, 2); // '1 2' → '12'
    });

    test('collapses selection when both offsets map to same position', () {
      final result = format(_val('  123', base: 0, extent: 2));
      expect(result.text, '123');
      expect(result.selection.baseOffset, 0);
      expect(result.selection.extentOffset, 0);
    });
  });
}
