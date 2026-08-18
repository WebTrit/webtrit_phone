import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/main/main.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

void main() {
  const tabs = <BottomMenuTab>[
    KeypadBottomMenuTab(
      enabled: true,
      initial: true,
      titleL10n: 'main_BottomNavigationBarItemLabel_keypad',
      icon: Icons.dialpad,
    ),
    FavoritesBottomMenuTab(
      enabled: true,
      initial: false,
      titleL10n: 'main_BottomNavigationBarItemLabel_favorites',
      icon: Icons.star,
    ),
  ];

  testWidgets('the icon decoration a host hands in reaches the bar', (tester) async {
    // The badge went from built-in to an argument threaded host -> screen ->
    // bar; nothing but this test notices the middle of that chain going
    // missing, since dropping the argument compiles clean.
    const marker = Key('decorated-by-the-host');

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MainScreen(
          body: const SizedBox.shrink(),
          tabs: tabs,
          currentIndex: 0,
          decorateTabIcon: (tab, icon) =>
              tab.flavor == MainFlavor.keypad ? KeyedSubtree(key: marker, child: icon) : icon,
        ),
      ),
    );

    expect(find.byKey(marker), findsOneWidget);
  });
}
