import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone_number/src/phone_parser.dart';

void main() {
  group('phone parser', () {
    test('replaces look-alike digits with plain ones', () {
      // Mathematical bold digits, as they arrive when a number is copied out of
      // a chat or a styled web page.
      expect(PhoneParser.normalize('\u{1D7D7}\u{1D7CF}\u{1D7D0}'), equals('912'));
      // Monospace and double-struck digits, from the same styled-text families.
      expect(PhoneParser.normalize('\u{1D7F6}\u{1D7E2}\u{1D7EB}'), equals('009'));
    });

    test('keeps a number that already uses plain digits', () {
      expect(PhoneParser.normalize('+380671234567'), equals('+380671234567'));
      expect(PhoneParser.normalize('*000#'), equals('*000#'));
    });

    test('keeps everything it is not meant to replace, spacing included', () {
      // Stripping the punctuation people type is the dialer's job
      // (PhoneNormalizingFormatter.sanitize), not this one's.
      expect(PhoneParser.normalize('+380 (67) 123 45 67'), equals('+380 (67) 123 45 67'));
      expect(PhoneParser.normalize('67 123-45-67'), equals('67 123-45-67'));
    });

    test('handles an empty number', () {
      expect(PhoneParser.normalize(''), equals(''));
    });
  });
}
