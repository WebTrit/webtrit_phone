import 'package:flutter_test/flutter_test.dart';

import 'package:pub_semver/pub_semver.dart';
import 'package:webtrit_phone/utils/version_utils.dart';

void main() {
  group('tryParseVersion', () {
    test('parses a valid semver string', () {
      expect(tryParseVersion('1.5.0'), Version(1, 5, 0));
      expect(tryParseVersion('1.5.0-alpha.1'), Version(1, 5, 0, pre: 'alpha.1'));
    });

    test('returns null for null', () {
      expect(tryParseVersion(null), isNull);
    });

    test('returns null for an empty string', () {
      expect(tryParseVersion(''), isNull);
    });

    test('returns null for a malformed string', () {
      expect(tryParseVersion('not-a-version'), isNull);
      expect(tryParseVersion('1.x'), isNull);
    });

    test('returns null for a non-String value', () {
      expect(tryParseVersion(123), isNull);
      expect(tryParseVersion(const {}), isNull);
    });
  });
}
