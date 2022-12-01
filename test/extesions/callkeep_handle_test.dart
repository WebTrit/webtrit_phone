import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/extensions/extensions.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CallkeepHandleExtension', () {
    test('Generic', () {
      expect(
        const CallkeepHandle(
          type: CallkeepHandleType.generic,
          value: 'qwerty',
        ).normalizedValue(),
        equals('qwerty'),
      );
    });

    test('Number', () {
      expect(
        const CallkeepHandle(
          type: CallkeepHandleType.number,
          value: '977-28-35-02',
        ).normalizedValue(),
        equals('977283502'),
      );
    });

    test('Email', () {
      expect(
        const CallkeepHandle(
          type: CallkeepHandleType.email,
          value: 'a@m.c',
        ).normalizedValue(),
        equals('a@m.c'),
      );
    });
  });
}
