import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/models/models.dart';

void main() {
  const bundled = [Locale('en'), Locale('it'), Locale('th'), Locale('uk')];

  List<String> codes(List<Locale> locales) => locales.map((l) => l.languageCode).toList();

  group('LocalizationConfig.resolve', () {
    test('empty allowlist keeps all bundled locales', () {
      expect(LocalizationConfig.resolve(bundled, const []), bundled);
    });

    test('filters to the requested subset, preserving bundle order', () {
      expect(codes(LocalizationConfig.resolve(bundled, const ['it', 'en'])), ['en', 'it']);
    });

    test('single valid code restricts to that language', () {
      expect(codes(LocalizationConfig.resolve(bundled, const ['en'])), ['en']);
    });

    test('unknown codes are ignored, valid ones kept', () {
      expect(codes(LocalizationConfig.resolve(bundled, const ['en', 'fr', 'de'])), ['en']);
    });

    test('all-unknown allowlist falls back to the full bundled set', () {
      expect(LocalizationConfig.resolve(bundled, const ['fr', 'de']), bundled);
    });

    test('codes are matched case-insensitively and trimmed', () {
      expect(codes(LocalizationConfig.resolve(bundled, const [' EN ', 'IT'])), ['en', 'it']);
    });

    test('blank/whitespace-only codes are ignored (treated as no restriction)', () {
      expect(LocalizationConfig.resolve(bundled, const ['   ', '']), bundled);
    });
  });
}
