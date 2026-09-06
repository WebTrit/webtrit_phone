import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_appearance_theme/models/models.dart';
import 'package:webtrit_phone/features/call/view/call_screen_style.dart';
import 'package:webtrit_phone/theme/extension/extension.dart';
import 'package:webtrit_phone/theme/factory/styles/call_screen_style_factory.dart';

/// Pins the colors a theme produces for every call-action button in every state
/// the call screen can put them in.
///
/// The theme below is the test's own, deliberately uneven: one button sets
/// everything, one sets a single color, the rest set nothing. That covers the
/// three things worth pinning - what a theme dictates, what is derived from a
/// half-filled theme, and what comes from the color scheme when a theme is
/// silent. The bundled themes are NOT used on purpose: a white-label build
/// replaces those files with the customer's own, and this test must keep
/// testing the app rather than whichever theme happens to be checked out.
///
/// The color scheme is spelled out below for the same reason, and so an SDK
/// upgrade that retunes Material's palette generation cannot move these
/// expectations: every role the call screen reads is given here. That also
/// makes brightness irrelevant to these buttons - the factory picks the same
/// roles either way - so one snapshot covers both themes.
///
/// A `selected` row follows the theme when it names a switched-on color, and
/// the palette when it does not - both cases are below. A `sel+dis` row is a
/// control that is switched on and unavailable at once: it dims its
/// switched-on look rather than dropping back to the resting one.
///
/// `camera` is the toggle that sets a resting background, so its disabled row
/// is where the dimming rule shows: a button fades its own color, not the one
/// the palette would have given it, and a color that is already translucent
/// keeps fading instead of being snapped to a fixed alpha. `muted` is the
/// toggle that colors its switched-on look, so its selected row shows the theme
/// winning over the palette.
///
/// What the palette rows pin is the difference between off and on. Every
/// button the theme leaves alone rests at `#66EEF3F6` - the surface at
/// [kRestingOpacity] - and a toggle switches to `#FFEEF3F6`, the same surface
/// opaque. A change that makes those two the same tone is a call screen where
/// nobody can tell a muted microphone from a live one, which is what this
/// snapshot is here to refuse.
const _themeJson = '''
{
  "dialing": {
    "actions": {
      "callStart": {
        "backgroundColor": "#75B943",
        "foregroundColor": "#FFFFFFFF",
        "iconColor": "#FFEEEEEE",
        "disabledBackgroundColor": "#66DDE0E3",
        "disabledForegroundColor": "#848581",
        "disabledIconColor": "#848581"
      },
      "hangup": {
        "backgroundColor": "#E74C3C"
      },
      "camera": {
        "backgroundColor": "#66FFFFFF",
        "iconColor": "#FF102030"
      },
      "muted": {
        "selectedBackgroundColor": "#FF0B6E4F",
        "selectedIconColor": "#FFFFFFFF"
      }
    }
  }
}
''';

/// Every color-scheme role the call screen resolves, pinned to a value of the
/// test's own so the assertions below depend on nothing but this file.
ColorScheme _scheme() {
  return ColorScheme.fromSeed(seedColor: const Color(0xFF3F51B5)).copyWith(
    error: const Color(0xFFB3261E),
    onError: const Color(0xFFFFFFFF),
    secondary: const Color(0xFF123752),
    onSecondary: const Color(0xFFEAF1F6),
    tertiary: const Color(0xFF3F7A2E),
    onTertiary: const Color(0xFFF2FBEF),
    surface: const Color(0xFFEEF3F6),
    onSurface: const Color(0xFF30302F),
    surfaceContainer: const Color(0xFFE3E9ED),
    surfaceContainerHigh: const Color(0xFFDCE3E8),
    surfaceContainerHighest: const Color(0xFFD5DDE3),
    onSecondaryFixedVariant: const Color(0xFF848581),
  );
}

void main() {
  const buttons = <String>['callStart', 'hangup', 'transfer', 'swap', 'key', 'camera', 'muted', 'speaker', 'held'];

  const states = <String, Set<WidgetState>>{
    'normal': <WidgetState>{},
    'selected': {WidgetState.selected},
    'disabled': {WidgetState.disabled},
    // Both at once happens for real: a toggle stays selected while the call
    // renegotiates and its callback goes null. Disabled has to win.
    'sel+dis': {WidgetState.selected, WidgetState.disabled},
  };

  ButtonStyle? buttonOf(CallScreenActionsStyle style, String name) {
    return switch (name) {
      'callStart' => style.callStart,
      'hangup' => style.hangup,
      'transfer' => style.transfer,
      'swap' => style.swap,
      'key' => style.key,
      'camera' => style.camera,
      'muted' => style.muted,
      'speaker' => style.speaker,
      'held' => style.held,
      _ => throw ArgumentError('Unknown call action button: $name'),
    };
  }

  String describe(Color? color) => color == null ? 'null' : color.toCSSColorString();

  String snapshot() {
    final colors = _scheme();
    final dialing = ThemePageConfig.fromJson(jsonDecode(_themeJson) as Map<String, dynamic>).dialing;
    final actions = CallScreenStyleFactory(colors, dialing, null).create().primary!.actions!;

    final lines = <String>[];
    for (final name in buttons) {
      final style = buttonOf(actions, name)!;
      lines.add(name);
      for (final entry in states.entries) {
        final state = entry.value;
        lines.add(
          '  ${entry.key.padRight(8)} '
          'bg=${describe(style.backgroundColor?.resolve(state))} '
          'fg=${describe(style.foregroundColor?.resolve(state))} '
          'icon=${describe(style.iconColor?.resolve(state))}',
        );
      }
    }
    return lines.join('\n');
  }

  test('an unset button rests translucent and switches to opaque', () {
    expect(snapshot(), '''
callStart
  normal   bg=#FF75B943 fg=#FFFFFFFF icon=#FFEEEEEE
  selected bg=#FF75B943 fg=#FFFFFFFF icon=#FFEEEEEE
  disabled bg=#66DDE0E3 fg=#FF848581 icon=#FF848581
  sel+dis  bg=#66DDE0E3 fg=#FF848581 icon=#FF848581
hangup
  normal   bg=#FFE74C3C fg=#FFFFFFFF icon=#FFEEF3F6
  selected bg=#FFE74C3C fg=#FFFFFFFF icon=#FFEEF3F6
  disabled bg=#66E74C3C fg=#66FFFFFF icon=#66EEF3F6
  sel+dis  bg=#66E74C3C fg=#66FFFFFF icon=#66EEF3F6
transfer
  normal   bg=#66EEF3F6 fg=#FFEEF3F6 icon=#FFEEF3F6
  selected bg=#66EEF3F6 fg=#FFEEF3F6 icon=#FFEEF3F6
  disabled bg=#29EEF3F6 fg=#66EEF3F6 icon=#66EEF3F6
  sel+dis  bg=#29EEF3F6 fg=#66EEF3F6 icon=#66EEF3F6
swap
  normal   bg=#66EEF3F6 fg=#FFEEF3F6 icon=#FFEEF3F6
  selected bg=#66EEF3F6 fg=#FFEEF3F6 icon=#FFEEF3F6
  disabled bg=#29EEF3F6 fg=#66EEF3F6 icon=#66EEF3F6
  sel+dis  bg=#29EEF3F6 fg=#66EEF3F6 icon=#66EEF3F6
key
  normal   bg=#66EEF3F6 fg=#FFEEF3F6 icon=#FFEEF3F6
  selected bg=#66EEF3F6 fg=#FFEEF3F6 icon=#FFEEF3F6
  disabled bg=#29EEF3F6 fg=#66EEF3F6 icon=#66EEF3F6
  sel+dis  bg=#29EEF3F6 fg=#66EEF3F6 icon=#66EEF3F6
camera
  normal   bg=#66FFFFFF fg=#FFEEF3F6 icon=#FF102030
  selected bg=#FFEEF3F6 fg=#FF30302F icon=#FF848581
  disabled bg=#29FFFFFF fg=#66EEF3F6 icon=#66EEF3F6
  sel+dis  bg=#66EEF3F6 fg=#6630302F icon=#66EEF3F6
muted
  normal   bg=#66EEF3F6 fg=#FFEEF3F6 icon=#FFEEF3F6
  selected bg=#FF0B6E4F fg=#FF30302F icon=#FFFFFFFF
  disabled bg=#29EEF3F6 fg=#66EEF3F6 icon=#66EEF3F6
  sel+dis  bg=#660B6E4F fg=#6630302F icon=#66EEF3F6
speaker
  normal   bg=#66EEF3F6 fg=#FFEEF3F6 icon=#FFEEF3F6
  selected bg=#FFEEF3F6 fg=#FF30302F icon=#FF848581
  disabled bg=#29EEF3F6 fg=#66EEF3F6 icon=#66EEF3F6
  sel+dis  bg=#66EEF3F6 fg=#6630302F icon=#66EEF3F6
held
  normal   bg=#66EEF3F6 fg=#FFEEF3F6 icon=#FFEEF3F6
  selected bg=#FFEEF3F6 fg=#FF30302F icon=#FF848581
  disabled bg=#29EEF3F6 fg=#66EEF3F6 icon=#66EEF3F6
  sel+dis  bg=#66EEF3F6 fg=#6630302F icon=#66EEF3F6''');
  });
  // A theme written before the page config had `actions` still has to draw
  // nine buttons. It used to be caught by the retired widget-level styles,
  // which were a defaulted field and therefore never absent; with those gone,
  // an unmapped config would reach `TextButton` as no style at all and lose
  // the circle a call button is.
  test('a theme with no actions config still styles every button', () {
    final colors = _scheme();
    final actions = CallScreenStyleFactory(colors, const CallPageConfig(), null).create().primary!.actions!;

    for (final name in ['callStart', 'hangup', 'transfer', 'swap', 'key', 'camera', 'muted', 'speaker', 'held']) {
      final button = buttonOf(actions, name);
      expect(button, isNotNull, reason: '$name has no style');
      expect(
        button!.backgroundColor?.resolve(const <WidgetState>{}),
        isNotNull,
        reason: '$name has no background, so it would not draw a circle',
      );
    }
  });
}
