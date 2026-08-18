import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/main/main.dart';
import 'package:webtrit_phone/models/models.dart';

void main() {
  const keypad = KeypadBottomMenuTab(
    enabled: true,
    initial: true,
    titleL10n: 'main_BottomNavigationBarItemLabel_keypad',
    icon: Icons.dialpad,
  );
  const help = EmbeddedBottomMenuTab(id: 'help', enabled: true, initial: false, titleL10n: 'Help', icon: Icons.help);
  const shop = EmbeddedBottomMenuTab(
    id: 'shop',
    enabled: true,
    initial: false,
    titleL10n: 'Shop',
    icon: Icons.shopping_bag,
  );
  const recents = RecentsBottomMenuTab(
    supportsCallHistory: false,
    enabled: true,
    initial: false,
    titleL10n: 'main_BottomNavigationBarItemLabel_recents',
    icon: Icons.history,
  );
  const cdrsRecents = RecentsBottomMenuTab(
    supportsCallHistory: true,
    enabled: true,
    initial: false,
    titleL10n: 'main_BottomNavigationBarItemLabel_recents',
    icon: Icons.history,
  );

  // On a configuration reload the tabs router re-matches the active tab by
  // route name, and every embedded section shares one - so it lands on the
  // first of them whichever was open. These pin the correction that puts the
  // user back.
  group('reactivationIndex', () {
    test('puts the user back on the embedded section they had open', () {
      // A capability flip changed the recents tab, which replaces the routes;
      // the router landed on the first embedded section (index 1).
      final index = BottomMenuTabHandler.reactivationIndex(
        previousTabs: const [recents, help, shop],
        previousPath: shop.routePath,
        tabs: const [cdrsRecents, help, shop],
        activeIndex: 1,
      );
      expect(index, 2);
    });

    test('follows the open tab to its new position when the set is reordered', () {
      final index = BottomMenuTabHandler.reactivationIndex(
        previousTabs: const [help, shop],
        previousPath: shop.routePath,
        tabs: const [keypad, shop, help],
        activeIndex: 2,
      );
      expect(index, 1);
    });

    test('leaves the router alone while the tab set is unchanged', () {
      final index = BottomMenuTabHandler.reactivationIndex(
        previousTabs: const [keypad, help, shop],
        previousPath: shop.routePath,
        tabs: const [keypad, help, shop],
        activeIndex: 0,
      );
      expect(index, isNull);
    });

    test('accepts the router\'s choice when the open tab is gone', () {
      final index = BottomMenuTabHandler.reactivationIndex(
        previousTabs: const [keypad, help, shop],
        previousPath: shop.routePath,
        tabs: const [keypad, help],
        activeIndex: 1,
      );
      expect(index, isNull);
    });

    test('needs no correction when the router already landed right', () {
      final index = BottomMenuTabHandler.reactivationIndex(
        previousTabs: const [recents, shop],
        previousPath: shop.routePath,
        tabs: const [cdrsRecents, shop],
        activeIndex: 1,
      );
      expect(index, isNull);
    });

    test('does nothing on the very first frame', () {
      final index = BottomMenuTabHandler.reactivationIndex(
        previousTabs: null,
        previousPath: null,
        tabs: const [keypad, help],
        activeIndex: 0,
      );
      expect(index, isNull);
    });
  });
}
