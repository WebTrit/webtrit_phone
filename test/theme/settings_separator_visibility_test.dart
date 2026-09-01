import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_appearance_theme/models/models.dart';
import 'package:webtrit_phone/theme/factory/styles/settings_screen_style_factory.dart';

/// Whether the settings list draws separators.
///
/// One field says so, and a style that exists always answers it. The boolean
/// that used to say it beside the style is gone from the document: the store
/// folded it into `separator.enabled` when it dropped the column.
///
/// The distinction that matters: the store writes `separator` as soon as
/// either of its two fields is filled, so a colour alone produces a style that
/// names no visibility - and nothing is what a hidden separator was turned
/// back on by.
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

  // The case the object-presence rule got wrong: colouring a separator used to
  // produce a style that said nothing, and nothing read as shown.
  test('a style that names only a colour still answers', () {
    expect(visibility('{"separator": {"color": "#CCCCCC"}}'), isTrue);
  });

  // The shape the store emits for that theme: the column is empty, so the key
  // arrives explicitly null rather than absent.
  test('a style whose visibility is null still answers', () {
    expect(visibility('{"separator": {"enabled": null, "color": "#CCCCCC"}}'), isTrue);
  });

  // Hiding one and colouring it is a style that answers both questions.
  test('a hidden separator stays hidden when it is coloured', () {
    expect(visibility('{"separator": {"enabled": false, "color": "#CCCCCC"}}'), isFalse);
  });

  // A theme with no separator style at all decides nothing here, and the screen
  // reads that as shown. The default moved there when the retired boolean - and
  // its own default of `true` - went.
  test('a theme with no separator style leaves the answer to the screen', () {
    expect(visibility('{}'), isNull);
  });
}
