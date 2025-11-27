import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/extensions/extensions.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CallkeepHandleExtension', () {
    test('Generic', () {
      expect(
        const CallkeepHandle(type: CallkeepHandleType.generic, value: 'qwerty').normalizedValue(),
        equals('qwerty'),
      );
    });

    test('Number', () {
      expect(
        const CallkeepHandle(type: CallkeepHandleType.number, value: '𝟗77-28-35-02').normalizedValue(),
        equals('977-28-35-02'),
      );
    });

    test('Email', () {
      expect(const CallkeepHandle(type: CallkeepHandleType.email, value: 'a@m.c').normalizedValue(), equals('a@m.c'));
    });

    test('Number - keeps plain ASCII digits unchanged', () {
      expect(
        const CallkeepHandle(type: CallkeepHandleType.number, value: '123456').normalizedValue(),
        equals('123456'),
      );
    });

    test('Number - mixes fancy and plain digits', () {
      expect(
        const CallkeepHandle(type: CallkeepHandleType.number, value: '𝟗3𝟡-12-𝟠4').normalizedValue(),
        equals('939-12-84'),
      );
    });

    test('Number - does not truncate after "-"', () {
      expect(
        const CallkeepHandle(type: CallkeepHandleType.number, value: '1037790-test').normalizedValue(),
        equals('1037790-test'),
      );
    });

    test('Number - keeps unknown characters if not in mapping', () {
      expect(
        const CallkeepHandle(type: CallkeepHandleType.number, value: '12a-34#56').normalizedValue(),
        equals('12a-34#56'),
      );
    });
  });
}
