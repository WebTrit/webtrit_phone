import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/extensions/caller_id_settings.dart';
import 'package:webtrit_phone/models/models.dart';

void main() {
  group('CallerIdSettingsX.resolveFromNumber', () {
    test('returns null when settings are empty', () {
      expect(const CallerIdSettings().resolveFromNumber('+12345'), isNull);
    });

    test('returns defaultNumber when no matcher applies', () {
      const settings = CallerIdSettings(defaultNumber: '500');
      expect(settings.resolveFromNumber('+12345'), '500');
    });

    test('returns matched number over defaultNumber', () {
      final settings = CallerIdSettings(defaultNumber: '500', matchers: [PrefixMatcher('+1', '100')]);
      expect(settings.resolveFromNumber('+12345'), '100');
    });

    test('returns longest-prefix match', () {
      final settings = CallerIdSettings(matchers: [PrefixMatcher('+1', '100'), PrefixMatcher('+1268', '268')]);
      expect(settings.resolveFromNumber('+126812345678'), '268');
    });

    test('falls back to defaultNumber when no matcher matches', () {
      final settings = CallerIdSettings(defaultNumber: '500', matchers: [PrefixMatcher('+44', '440')]);
      expect(settings.resolveFromNumber('+12345'), '500');
    });

    test('normalises plus sign on both sides', () {
      final settings = CallerIdSettings(matchers: [PrefixMatcher('1268', '268')]);
      // matcher without +, destination with +
      expect(settings.resolveFromNumber('+126812345678'), '268');
    });
  });
}
