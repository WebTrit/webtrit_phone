import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/main/main.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

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

  Future<void> pumpShell(
    WidgetTester tester, {
    required List<BottomMenuTab> tabs,
    required int currentIndex,
    bool transferInProgress = false,
  }) {
    return tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: MainScreen(
          body: const Scaffold(body: SizedBox.expand()),
          tabs: tabs,
          currentIndex: currentIndex,
          transferInProgress: transferInProgress,
        ),
      ),
    );
  }

  group('the banner that says a call is waiting for a destination', () {
    const messagingTab = MessagingBottomMenuTab(
      enabled: true,
      initial: false,
      titleL10n: 'main_BottomNavigationBarItemLabel_messaging',
      icon: Icons.chat,
    );

    testWidgets('is not shown while nothing is being transferred', (tester) async {
      await pumpShell(tester, tabs: tabs, currentIndex: 0);

      expect(find.byType(TransferBottomNavigationBar), findsNothing);
    });

    testWidgets('is shown on a section that has a destination to offer', (tester) async {
      // The keypad included: a number can be dialled there and handed over,
      // and until now it was the one such section that never said so.
      await pumpShell(tester, tabs: tabs, currentIndex: 0, transferInProgress: true);

      expect(tabs[0].flavor, MainFlavor.keypad);
      expect(find.byType(TransferBottomNavigationBar), findsOneWidget);
    });

    testWidgets('is not shown on a section that has none', (tester) async {
      // A page of conversations has nobody to hand the call to, so announcing
      // the choice there offers something that cannot be done.
      await pumpShell(tester, tabs: const [...tabs, messagingTab], currentIndex: 2, transferInProgress: true);

      expect(find.byType(TransferBottomNavigationBar), findsNothing);
    });

    testWidgets('sits above the tab bar rather than behind it', (tester) async {
      // The whole reason it moved here: drawn by a section, it landed beneath
      // the bar this screen floats over the page, and nobody ever saw it.
      await pumpShell(tester, tabs: tabs, currentIndex: 0, transferInProgress: true);

      final banner = tester.getRect(find.byType(TransferBottomNavigationBar));
      final bar = tester.getRect(find.byType(MainBottomNavigationBar));

      expect(banner.bottom, lessThanOrEqualTo(bar.top));
    });

    testWidgets('spans the screen, like the bar under it', (tester) async {
      // A Column gives a child only the width it asks for, and the banner is a
      // box around a line of text - left alone it shrinks to the words and
      // centres, reading as a label rather than as the state of the screen.
      await pumpShell(tester, tabs: tabs, currentIndex: 0, transferInProgress: true);

      final banner = tester.getRect(find.byType(TransferBottomNavigationBar));
      final bar = tester.getRect(find.byType(MainBottomNavigationBar));

      expect(banner.width, bar.width);
    });

    testWidgets('is frosted like the bar, not a solid strip pasted over it', (tester) async {
      await pumpShell(tester, tabs: tabs, currentIndex: 0, transferInProgress: true);

      // Under the same backdrop filter as the bar, so both sample one backdrop
      // and there is no seam between them.
      expect(
        find.ancestor(of: find.byType(TransferBottomNavigationBar), matching: find.byType(BackdropFilter)),
        findsOneWidget,
      );
      expect(
        find.ancestor(of: find.byType(MainBottomNavigationBar), matching: find.byType(BackdropFilter)),
        findsOneWidget,
      );

      // And it lets that blur through rather than covering it.
      final fill = tester.widget<Container>(
        find.descendant(of: find.byType(TransferBottomNavigationBar), matching: find.byType(Container)).first,
      );
      expect((fill.color ?? (fill.decoration as BoxDecoration).color)!.a, lessThan(1.0));
    });

    testWidgets('is still said where a one-section menu draws no bar', (tester) async {
      await pumpShell(tester, tabs: [tabs.first], currentIndex: 0, transferInProgress: true);

      expect(find.byType(MainBottomNavigationBar), findsNothing);
      expect(find.byType(TransferBottomNavigationBar), findsOneWidget);
    });
  });

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

  testWidgets('a menu of one section shows the body alone, with no bar', (tester) async {
    // The rule lives in the screen itself so the app and every preview agree
    // by construction - their disagreement over a one-tab menu was a bug.
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MainScreen(
          body: const Scaffold(body: SizedBox.shrink()),
          tabs: [tabs.first],
          currentIndex: 0,
        ),
      ),
    );

    expect(find.byType(MainBottomNavigationBar), findsNothing);

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MainScreen(body: const SizedBox.shrink(), tabs: tabs, currentIndex: 0),
      ),
    );

    expect(find.byType(MainBottomNavigationBar), findsOneWidget);
  });
}
