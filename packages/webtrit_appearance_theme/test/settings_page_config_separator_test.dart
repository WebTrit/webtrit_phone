import 'package:test/test.dart';

import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

void main() {
  group('SettingsPageConfig.separator', () {
    group('legacy showSeparators migration', () {
      test('legacy showSeparators=false folds into separator.enabled=false (default color)', () {
        final config = SettingsPageConfig.fromJson({'showSeparators': false});

        expect(config.separator, isNotNull);
        expect(config.separator?.enabled, isFalse);
        expect(config.separator?.color, isNull);
      });

      test('legacy showSeparators=true folds into separator.enabled=true', () {
        final config = SettingsPageConfig.fromJson({'showSeparators': true});

        expect(config.separator?.enabled, isTrue);
      });

      test('explicit separator wins over legacy showSeparators (no migration)', () {
        final config = SettingsPageConfig.fromJson({
          'showSeparators': true,
          'separator': {'enabled': false, 'color': '#FF0000'},
        });

        expect(config.separator?.enabled, isFalse);
        expect(config.separator?.color, '#FF0000');
      });

      test('migration does not mutate the caller json', () {
        final json = <String, Object?>{'showSeparators': false};
        SettingsPageConfig.fromJson(json);

        expect(json.containsKey('separator'), isFalse);
      });
    });

    group('new separator field', () {
      test('absent separator and no legacy flag → null (inherit default)', () {
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
    });
  });
}
