import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/settings/features/caller_id/widgets/widgets.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/caller_id_settings.dart';
import 'package:webtrit_phone/theme/theme.dart';

void main() {
  /// The scheme the app actually ships, not Material's baseline: the two
  /// disagree on these very roles, so a test built on the baseline would say
  /// nothing about what anyone sees.
  ColorScheme shippedScheme(Brightness brightness) {
    final name = brightness == Brightness.light ? 'light' : 'dark';
    final json = jsonDecode(File('assets/themes/original.color_scheme.$name.config.json').readAsStringSync());
    final config = ColorSchemeConfig.fromJson(json as Map<String, dynamic>);

    return config.toColorScheme(seedColor: config.seedColor.toColor(), brightness: brightness);
  }

  Widget wrap(ColorScheme colorScheme) => MaterialApp(
    theme: ThemeData.from(colorScheme: colorScheme),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: MatcherTile(matcher: PrefixMatcher('+1', '441'), index: 0)),
  );

  Color cardColour(WidgetTester tester) {
    final card = tester.widget<Container>(find.byType(Container).first);
    return (card.decoration! as BoxDecoration).color!;
  }

  testWidgets('a rule card is drawn on the theme, and in the light one nothing moves', (tester) async {
    final colorScheme = shippedScheme(Brightness.light);

    await tester.pumpWidget(wrap(colorScheme));

    expect(cardColour(tester), colorScheme.surfaceBright);
    expect(cardColour(tester), const Color(0xFFFFFFFF), reason: 'the shipped light theme paints this role white');
  });

  testWidgets('the same card is dark where the theme is dark', (tester) async {
    // What the hardcoded white cost: a white slab on a dark screen, with the
    // fields inside it already taking their colour from the theme.
    final colorScheme = shippedScheme(Brightness.dark);

    await tester.pumpWidget(wrap(colorScheme));

    expect(cardColour(tester), colorScheme.surfaceBright);
    expect(cardColour(tester).computeLuminance(), lessThan(0.1), reason: 'no white slab on a dark screen');
  });

  testWidgets('the fields inside the card keep an edge against it', (tester) async {
    // The card and the fields it holds are neighbours in the theme's ladder of
    // surfaces; picking the same rung for both would leave the fields invisible.
    for (final brightness in Brightness.values) {
      final colorScheme = shippedScheme(brightness);

      expect(
        colorScheme.surfaceBright,
        isNot(colorScheme.surfaceContainerLow),
        reason: 'card and field share a colour in $brightness',
      );
    }
  });
}
