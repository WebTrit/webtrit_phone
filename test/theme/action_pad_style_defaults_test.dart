import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_appearance_theme/models/models.dart';
import 'package:webtrit_phone/theme/factory/styles/action_pad_style_factory.dart';

/// What the three buttons under the dial pad look like when the theme sets none
/// of them.
///
/// They used to share one filled `secondary` style, so the button that places
/// the call, the one that opens the options beside it and the backspace under
/// it were the same circle. Telling a call button from a backspace is the whole
/// job of this palette, and it is the only thing asserted here - the exact
/// roles can move, three buttons reading alike cannot.
void main() {
  ColorScheme scheme([Brightness brightness = Brightness.light]) =>
      ColorScheme.fromSeed(seedColor: const Color(0xFF1A73E8), brightness: brightness);

  Color? backgroundOf(ButtonStyle? style) => style?.backgroundColor?.resolve(const <WidgetState>{});

  Color? disabledBackgroundOf(ButtonStyle? style) =>
      style?.backgroundColor?.resolve(const <WidgetState>{WidgetState.disabled});

  /// How far apart two fills are at their widest channel, which is as much as a
  /// number can say about whether an eye tells them apart.
  double apart(Color a, Color b) =>
      [(a.r - b.r).abs(), (a.g - b.g).abs(), (a.b - b.b).abs()].reduce((x, y) => x > y ? x : y);

  ({Color? call, Color? options, Color? backspace}) backgrounds({ActionPadWidgetConfig? config}) {
    final styles = ActionPadStyleFactory(scheme(), config, null).create().primary;
    return (
      call: backgroundOf(styles?.primary?.style),
      options: backgroundOf(styles?.secondary?.style),
      backspace: backgroundOf(styles?.backspace?.style),
    );
  }

  test('an unset call button is not the same colour as the backspace', () {
    final resolved = backgrounds();

    expect(resolved.call, isNotNull);
    expect(resolved.call, isNot(resolved.backspace));
    expect(resolved.call, isNot(resolved.options));
    expect(resolved.options, isNot(resolved.backspace));
  });

  // The same green the call screen starts a call with: one logical button
  // should not be one colour on one screen and another on the next.
  test('an unset call button takes the palette tertiary, as the call screen does', () {
    final colors = scheme();

    expect(backgrounds().call, colors.tertiary);
  });

  test('an unset backspace is a surface tone rather than a filled accent', () {
    final colors = scheme();

    expect(backgrounds().backspace, colors.surfaceContainerHighest);
  });

  // The screen opens on an empty number, and an empty number disables all three
  // buttons, so a dead backspace is the first thing anyone sees. The shared
  // disabled fill is a faded neutral, which for a button already resting on a
  // surface tone lands within a couple of percent of where it started.
  for (final brightness in Brightness.values) {
    test('a disabled backspace does not look like an enabled one in $brightness', () {
      final colors = scheme(brightness);
      final backspace = ActionPadStyleFactory(colors, null, null).create().primary?.backspace?.style;

      final resting = backgroundOf(backspace)!;
      final dead = Color.alphaBlend(disabledBackgroundOf(backspace)!, colors.surface);

      expect(apart(resting, dead), greaterThan(0.05));
    });
  }

  // The fallback is what an unset button takes, and nothing more: a theme that
  // names a colour still wins.
  test('a theme that sets the call button keeps its colour', () {
    const config = ActionPadWidgetConfig(callStart: ButtonStyleConfig(backgroundColor: '#123456'));

    expect(backgrounds(config: config).call, const Color(0xFF123456));
  });
}
