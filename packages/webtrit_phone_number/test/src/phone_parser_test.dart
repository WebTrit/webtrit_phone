import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone_number/src/phone_parser.dart';

void main() {
  group('phone parser', () {
    test('normalize', () {
      expect(PhoneParser.normalize('(67) 123 45 67'), equals('671234567'));
      expect(PhoneParser.normalize('+380 (67) 123 45 67'),
          equals('+380671234567'));
      expect(PhoneParser.normalize('123 45 67'), equals('1234567'));
      expect(PhoneParser.normalize('67 123-45-67'), equals('671234567'));
      expect(PhoneParser.normalize('#123#'), equals('#123#'));
      expect(PhoneParser.normalize('123# 456 789'), equals('123#456789'));
      expect(PhoneParser.normalize('*987'), equals('*987'));
      expect(PhoneParser.normalize('*000#'), equals('*000#'));
    });
  });
}
