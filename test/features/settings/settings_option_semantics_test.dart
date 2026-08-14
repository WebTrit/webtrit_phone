import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';

void main() {
  group('option ids', () {
    test('an option is identified by what it means, not by its position', () {
      expect(settingsOptionId(settingsLanguageOptionIdPrefix, 'uk'), 'settingsLanguageOptionUk');
      expect(settingsOptionId(settingsThemeModeOptionIdPrefix, 'dark'), 'settingsThemeModeOptionDark');
      expect(settingsOptionId(settingsLanguageOptionIdPrefix, 'system'), 'settingsLanguageOptionSystem');
    });
  });
}
