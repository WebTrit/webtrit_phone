import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_appearance_theme/models/models.dart';

/// Guards the keys of the buttons under the dial pad, and the one rename they
/// have been through.
void main() {
  test('the action pad writes one key per button, plus the retired name of one', () {
    expect(const ActionPadWidgetConfig().toJson().keys.toSet(), {
      'callStart',
      'callTransfer',
      'backspace',
      // Still written so an app from an older release line keeps finding it.
      // Drops out of this list when the rename is finished off - see the TODO
      // on ActionPadWidgetConfig.
      'backspacePressed',
    });
  });

  test('a theme saved under the old backspace name is still read', () {
    const saved = '''
{
  "callStart": {"backgroundColor": "#75B943"},
  "backspacePressed": {"backgroundColor": "#00000000", "iconColor": "#494949"}
}
''';

    final config = ActionPadWidgetConfig.fromJson(jsonDecode(saved) as Map<String, dynamic>);

    expect(config.backspace.backgroundColor, '#00000000');
    expect(config.backspace.iconColor, '#494949');
    expect(config.callStart.backgroundColor, '#75B943');
  });

  test('and is written back under both names, with the same value', () {
    const saved = '{"backspacePressed": {"iconColor": "#494949"}}';

    final written = ActionPadWidgetConfig.fromJson(jsonDecode(saved) as Map<String, dynamic>).toJson();

    expect((written['backspace']! as Map)['iconColor'], '#494949');
    expect(written['backspacePressed'], written['backspace']);
  });

  test('the new name wins when a theme somehow carries both', () {
    const saved = '''
{
  "backspace": {"iconColor": "#111111"},
  "backspacePressed": {"iconColor": "#222222"}
}
''';

    final config = ActionPadWidgetConfig.fromJson(jsonDecode(saved) as Map<String, dynamic>);

    expect(config.backspace.iconColor, '#111111');
  });
}
