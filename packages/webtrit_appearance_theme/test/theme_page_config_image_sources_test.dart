import 'dart:convert';

import 'package:test/test.dart';

import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

/// The shipped themes under `assets/themes/` are replaced by the branding of
/// every white-label build, so this suite carries its own theme description and
/// asserts how the parsing behaves, not how one brand happens to look.
const _themeJson = '''
{
  "login": {
    "modeSelect": {
      "mainLogo": {
        "uri": "asset://assets/images/primary_logo.svg",
        "render": {
          "scale": 0.42,
          "alignment": "center",
          "padding": {"left": 0.0, "top": 0.0, "right": 0.0, "bottom": 0.0}
        }
      }
    },
    "switchPage": {
      "mainLogo": {
        "uri": "asset://assets/images/secondary_logo.svg",
        "render": {
          "scale": 0.25,
          "padding": {"left": 0, "top": 80, "right": 0, "bottom": 24}
        }
      }
    }
  },
  "about": {
    "mainLogo": {
      "uri": "https://example.com/logo.png",
      "render": {
        "scale": 0.25,
        "padding": {"left": 0.0, "top": 48.0, "right": 0.0, "bottom": 0.0}
      }
    }
  }
}
''';

void main() {
  group('ThemePageConfig image sources parsing', () {
    late Map<String, dynamic> json;

    setUp(() {
      json = jsonDecode(_themeJson) as Map<String, dynamic>;
    });

    test('parses login.modeSelect.mainLogo with render scale & zero padding', () {
      final config = ThemePageConfig.fromJson(json);

      final mainLogo = config.login.modeSelect.mainLogo;
      expect(mainLogo, isNotNull, reason: 'login.modeSelect.mainLogo should be present');

      expect(mainLogo!.uri, 'asset://assets/images/primary_logo.svg');

      expect(mainLogo.render, isNotNull, reason: 'render should be present for modeSelect.mainLogo');
      expect(mainLogo.render!.scale, closeTo(0.42, 1e-9));

      final p = mainLogo.render!.padding;
      expect(p?.left, closeTo(0.0, 1e-9));
      expect(p?.top, closeTo(0.0, 1e-9));
      expect(p?.right, closeTo(0.0, 1e-9));
      expect(p?.bottom, closeTo(0.0, 1e-9));
    });

    test('parses login.switchPage.mainLogo with integer padding values', () {
      final config = ThemePageConfig.fromJson(json);

      final mainLogo = config.login.switchPage.mainLogo;
      expect(mainLogo, isNotNull, reason: 'login.switchPage.mainLogo should be present');

      expect(mainLogo!.uri, 'asset://assets/images/secondary_logo.svg');

      expect(mainLogo.render, isNotNull);
      expect(mainLogo.render!.scale, closeTo(0.25, 1e-9));

      final p = mainLogo.render!.padding;
      expect(p?.left, closeTo(0.0, 1e-9));
      expect(p?.top, closeTo(80.0, 1e-9));
      expect(p?.right, closeTo(0.0, 1e-9));
      expect(p?.bottom, closeTo(24.0, 1e-9));
    });

    test('parses about.mainLogo with a remote uri & non-zero top padding', () {
      final config = ThemePageConfig.fromJson(json);

      final mainLogo = config.about.mainLogo;
      expect(mainLogo, isNotNull, reason: 'about.mainLogo should be present');

      expect(mainLogo!.uri, 'https://example.com/logo.png');

      expect(mainLogo.render, isNotNull);
      expect(mainLogo.render!.scale, closeTo(0.25, 1e-9));

      final p = mainLogo.render!.padding;
      expect(p?.left, closeTo(0.0, 1e-9));
      expect(p?.top, closeTo(48.0, 1e-9));
      expect(p?.right, closeTo(0.0, 1e-9));
      expect(p?.bottom, closeTo(0.0, 1e-9));
    });

    test('leaves a logo absent when the theme does not describe one', () {
      final config = ThemePageConfig.fromJson(const {});

      expect(config.login.modeSelect.mainLogo, isNull);
      expect(config.about.mainLogo, isNull);
    });
  });
}
