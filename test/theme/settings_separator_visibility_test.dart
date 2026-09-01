import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_appearance_theme/models/models.dart';
import 'package:webtrit_phone/theme/factory/styles/settings_screen_style_factory.dart';

/// Whether the settings list draws separators.
///
/// One field says so, and a style that exists always answers it. The boolean it
/// replaced is folded in by `SettingsPageConfig.fromJson`, so these cases are
/// the fold as much as the resolution.
///
/// The distinction that matters: the store writes `separator` as soon as either
/// of its two fields is filled, so a colour alone used to produce a style that
/// said nothing about visibility - and nothing is what a hidden separator was
/// turned back on by.
void main() {
  bool? visibility(String json) {
    final config = SettingsPageConfig.fromJson(jsonDecode(json) as Map<String, dynamic>);
    return SettingsScreenStyleFactory(
      ColorScheme.fromSeed(seedColor: const Color(0xFF1A73E8)),
      config,
      null,
    ).create().primary?.showSeparators;
  }

  test('a style that says to hide them hides them', () {
    expect(visibility('{"separator": {"enabled": false}}'), isFalse);
  });

  test('a style that says to show them shows them', () {
    expect(visibility('{"separator": {"enabled": true}}'), isTrue);
  });

  // The theme that only ever had the boolean. `fromJson` folds it into the new
  // style, so this is the migration as much as the resolution.
  test('a theme with only the retired boolean keeps its answer', () {
    expect(visibility('{"showSeparators": false}'), isFalse);
  });

  // The case the object-presence rule got wrong: colouring a separator on a
  // brand that had turned separators off used to turn them back on.
  test('colouring a separator does not turn a hidden one back on', () {
    expect(visibility('{"separator": {"color": "#CCCCCC"}, "showSeparators": false}'), isFalse);
  });

  // And the other way round: a style that names visibility is the answer, even
  // when the retired boolean disagrees.
  test('a style that names visibility beats the retired boolean', () {
    expect(visibility('{"separator": {"enabled": true}, "showSeparators": false}'), isTrue);
  });

  // A theme with no separator style at all decides nothing here, and the screen
  // reads that as shown. The default moved there when the retired boolean - and
  // its own default of `true` - went.
  test('a theme with no separator style leaves the answer to the screen', () {
    expect(visibility('{}'), isNull);
  });

  // A style that exists cannot say nothing any more: `enabled` carries its own
  // default, so colouring one and saying nothing else means shown.
  test('a style that names only a colour still answers', () {
    expect(visibility('{"separator": {"color": "#CCCCCC"}}'), isTrue);
  });
}
