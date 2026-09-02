import 'package:test/test.dart';

import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

void main() {
  group('SettingsPageConfig.separator', () {
    test('an absent separator reads as null (inherit default)', () {
      final config = SettingsPageConfig.fromJson(<String, Object?>{});

      expect(config.separator, isNull);
    });

    test('parses enabled + color', () {
      final config = SettingsPageConfig.fromJson({
        'separator': {'enabled': true, 'color': '#CAC7D1'},
      });

      expect(config.separator?.enabled, isTrue);
      expect(config.separator?.color, '#CAC7D1');
    });

    test('round-trips through toJson/fromJson', () {
      const original = SettingsPageConfig(separator: SeparatorStyleConfig(enabled: false, color: '#123456'));

      final restored = SettingsPageConfig.fromJson(original.toJson());

      expect(restored.separator?.enabled, isFalse);
      expect(restored.separator?.color, '#123456');
    });

    // The retired boolean is folded where the value lives - the store does it
    // before the document is served, not this class. A document that still
    // carries the key answers nothing here.
    test('the retired showSeparators key says nothing on its own', () {
      final config = SettingsPageConfig.fromJson({'showSeparators': false});

      expect(config.separator, isNull);
    });
  });
}
