import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/call_routing/utils/resolve_from_number.dart';
import 'package:webtrit_phone/models/models.dart';

void main() {
  group('resolveFromNumber', () {
    test('returns null when settings are empty', () {
      expect(resolveFromNumber('+12345', const CallerIdSettings()), isNull);
    });

    test('returns defaultNumber when no matcher applies', () {
      const settings = CallerIdSettings(defaultNumber: '500');
      expect(resolveFromNumber('+12345', settings), '500');
    });

    test('returns matched number over defaultNumber', () {
      final settings = CallerIdSettings(defaultNumber: '500', matchers: [PrefixMatcher('+1', '100')]);
      expect(resolveFromNumber('+12345', settings), '100');
    });

    test('returns longest-prefix match', () {
      final settings = CallerIdSettings(matchers: [PrefixMatcher('+1', '100'), PrefixMatcher('+1268', '268')]);
      expect(resolveFromNumber('+126812345678', settings), '268');
    });

    test('falls back to defaultNumber when no matcher matches', () {
      final settings = CallerIdSettings(defaultNumber: '500', matchers: [PrefixMatcher('+44', '440')]);
      expect(resolveFromNumber('+12345', settings), '500');
    });

    test('normalises plus sign on both sides', () {
      final settings = CallerIdSettings(matchers: [PrefixMatcher('1268', '268')]);
      // matcher without +, destination with +
      expect(resolveFromNumber('+126812345678', settings), '268');
    });
  });
}
