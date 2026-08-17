import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_appearance_theme/models/models.dart';

/// Guards the shape of the call-action part of a theme file.
///
/// Themes are stored outside this repository and are written by the
/// configurator, so the set of keys is a contract, not an implementation
/// detail: renaming or dropping one silently changes how every saved theme is
/// read. Adding a field is fine, but it has to be a decision - which is what
/// these lists force.
///
/// When a test here fails, do not just paste the new key in. Check what happens
/// to themes already saved with the old one, and to app versions already built
/// against it.
void main() {
  group('button style keys', () {
    test('a button writes exactly these keys', () {
      expect(const ButtonStyleConfig().toJson().keys.toSet(), {
        'backgroundColor',
        'foregroundColor',
        'iconColor',
        'disabledBackgroundColor',
        'disabledForegroundColor',
        'disabledIconColor',
        'shadowColor',
        'disabledShadowColor',
        'surfaceTintColor',
        'overlayColor',
        'textStyle',
        'elevation',
        'padding',
        'minimumSize',
        'fixedSize',
        'maximumSize',
        'iconSize',
        'side',
        'shape',
        'visualDensity',
        'animationDuration',
      });
    });

    test('the call actions block writes one key per button plus the keypad text', () {
      expect(const CallPageActionsConfig().toJson().keys.toSet(), {
        'callStart',
        'hangup',
        'transfer',
        'camera',
        'muted',
        'speaker',
        'held',
        'swap',
        'key',
        'keypadInputStyle',
      });
    });
  });

  group('themes saved before the button style was unified', () {
    // A slice of a theme as the configurator used to write it, including the
    // text color that never painted anything on these icon-only buttons.
    const saved = '''
{
  "dialing": {
    "actions": {
      "hangup": {
        "backgroundColor": "#E74C3C",
        "foregroundColor": "#FFFFFFFF",
        "textColor": "#FFFFFFFF",
        "iconColor": "#FFFFFFFF",
        "disabledBackgroundColor": "#66DDE0E3",
        "disabledForegroundColor": "#848581",
        "disabledIconColor": "#848581"
      },
      "camera": {
        "backgroundColor": "#66FFFFFF"
      }
    }
  }
}
''';

    late CallPageActionsConfig actions;

    setUp(() {
      actions = ThemePageConfig.fromJson(jsonDecode(saved) as Map<String, dynamic>).dialing.actions!;
    });

    test('every color a saved theme set is still read', () {
      expect(actions.hangup.backgroundColor, '#E74C3C');
      expect(actions.hangup.foregroundColor, '#FFFFFFFF');
      expect(actions.hangup.iconColor, '#FFFFFFFF');
      expect(actions.hangup.disabledBackgroundColor, '#66DDE0E3');
      expect(actions.hangup.disabledForegroundColor, '#848581');
      expect(actions.hangup.disabledIconColor, '#848581');
      expect(actions.camera.backgroundColor, '#66FFFFFF');
    });

    test('and comes back out unchanged when the theme is saved again', () {
      final written = actions.hangup.toJson();
      final original = (jsonDecode(saved) as Map<String, dynamic>)['dialing']['actions']['hangup'] as Map;

      for (final entry in original.entries) {
        // The text color is the one key the app stopped carrying: these buttons
        // show an icon and no text, and nothing ever painted with it.
        if (entry.key == 'textColor') continue;
        expect(written[entry.key], entry.value, reason: '${entry.key} did not survive the round trip');
      }

      expect(written.containsKey('textColor'), isFalse);
    });

    test('a button the saved theme did not mention stays empty', () {
      expect(actions.swap.backgroundColor, isNull);
      expect(actions.swap.foregroundColor, isNull);
      expect(actions.swap.iconColor, isNull);
    });
  });
}
