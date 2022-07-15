import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/extensions/extensions.dart';

void main() {
  group('parsing', () {
    test('from language tag', () {
      const l1 = Locale('en');
      expect(
        LocaleExtension.fromLanguageTag(l1.toLanguageTag()),
        l1,
      );

      const l2 = Locale('fr', 'CH');
      expect(
        LocaleExtension.fromLanguageTag(l2.toLanguageTag()),
        l2,
      );

      const l3 = Locale.fromSubtags(
        countryCode: 'zh',
        scriptCode: 'cmn',
        languageCode: 'TW',
      );
      expect(
        LocaleExtension.fromLanguageTag(l3.toLanguageTag()),
        l3,
      );
    });

    test('from incorrect language tag', () {
      expect(
        () => LocaleExtension.fromLanguageTag(''),
        throwsA(isAssertionError),
      );
      expect(
        () => LocaleExtension.fromLanguageTag('a-b-c-d'),
        throwsA(isArgumentError),
      );
    });
  });

  group('flags', () {
    test('und country code is default', () {
      expect(LocaleExtension.defaultNull.isDefaultNull, true);
      expect(const Locale.fromSubtags(languageCode: 'und', scriptCode: 'und', countryCode: 'und').isDefaultNull, true);
    });

    test('not und country code is not default', () {
      expect(const Locale('en').isDefaultNull, false);
      expect(const Locale.fromSubtags(languageCode: 'uk').isDefaultNull, false);
    });
  });
}
