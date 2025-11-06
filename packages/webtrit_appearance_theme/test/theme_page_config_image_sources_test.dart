import 'package:test/test.dart';

import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

import 'helpers/helpers.dart';

void main() {
  group('ThemePageConfig image sources parsing', () {
    late Map<String, dynamic> json;

    setUp(() async {
      json = await loadFixtureJson('../../assets/themes/original.page.light.config.json');
    });

    test('parses login.modeSelect.mainLogo with render scale & padding', () {
      final config = ThemePageConfig.fromJson(json);

      final mainLogo = config.login.modeSelect.mainLogo;
      expect(mainLogo, isNotNull, reason: 'login.modeSelect.mainLogo should be present');

      expect(mainLogo!.uri, 'asset://assets/primary_onboardin_logo.svg');

      expect(mainLogo.render, isNotNull, reason: 'render should be present for modeSelect.mainLogo');
      expect(mainLogo.render!.scale, closeTo(0.42, 1e-9));

      final p = mainLogo.render!.padding;
      expect(p?.left, closeTo(0.0, 1e-9));
      expect(p?.top, closeTo(0.0, 1e-9));
      expect(p?.right, closeTo(0.0, 1e-9));
      expect(p?.bottom, closeTo(0.0, 1e-9));
    });

    test('parses login.switchPage.mainLogo with render scale & padding', () {
      final config = ThemePageConfig.fromJson(json);

      final mainLogo = config.login.switchPage.mainLogo;
      expect(mainLogo, isNotNull, reason: 'login.switchPage.mainLogo should be present');

      expect(mainLogo!.uri, 'asset://assets/secondary_onboardin_logo.svg');

      expect(mainLogo.render, isNotNull);
      expect(mainLogo.render!.scale, closeTo(0.25, 1e-9));

      final p = mainLogo.render!.padding;
      expect(p?.left, closeTo(0.0, 1e-9));
      expect(p?.top, closeTo(128.0, 1e-9));
      expect(p?.right, closeTo(0.0, 1e-9));
      expect(p?.bottom, closeTo(0.0, 1e-9));
    });

    test('parses about.mainLogo with render scale & non-zero top padding', () {
      final config = ThemePageConfig.fromJson(json);

      final mainLogo = config.about.mainLogo;
      expect(mainLogo, isNotNull, reason: 'about.mainLogo should be present');

      expect(mainLogo!.uri, 'asset://assets/primary_onboardin_logo.svg');

      expect(mainLogo.render, isNotNull);
      expect(mainLogo.render!.scale, closeTo(0.25, 1e-9));

      final p = mainLogo.render!.padding;
      expect(p?.left, closeTo(0.0, 1e-9));
      expect(p?.top, closeTo(48.0, 1e-9));
      expect(p?.right, closeTo(0.0, 1e-9));
      expect(p?.bottom, closeTo(0.0, 1e-9));
    });
  });
}
