import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_appearance_theme/models/models.dart';
import 'package:webtrit_phone/theme/factory/styles/settings_screen_style_factory.dart';

/// Whether the settings list draws separators.
///
/// Two things say so: the `separator` style, and the boolean it replaced. Which
/// one applies is decided by the value, not by whether the object holding it
/// exists - a distinction that matters because the store builds `separator` as
/// soon as either of its two fields is filled, so a colour alone produces a
/// style object that says nothing about visibility.
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

  // A theme that says neither still answers `true`, because the retired boolean
  // carries that as its default. Worth pinning: it is the reason removing that
  // field is not a no-op, and the reason the fallback above cannot simply be
  // dropped.
  test('a theme that says neither shows them', () {
    expect(visibility('{}'), isTrue);
  });
}
