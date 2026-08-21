import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/models/models.dart';

ContactsBottomMenuTab _contacts({required bool favoritesFilter}) => ContactsBottomMenuTab(
  contactSourceTypes: const [ContactSourceType.external],
  favoritesFilter: favoritesFilter,
  enabled: true,
  initial: false,
  titleL10n: 'main_BottomNavigationBarItemLabel_contacts',
  icon: Icons.contacts,
);

void main() {
  group('which contacts screen a deployment gets', () {
    test('a configuration that says nothing keeps the one it has', () {
      expect(_contacts(favoritesFilter: false).favoritesFilter, isFalse);
      expect(_contacts(favoritesFilter: false).routePath, MainFlavor.contacts.name);
    });

    test('offering the favourites filter is a separate destination', () {
      expect(
        _contacts(favoritesFilter: true).routePath,
        '${MainFlavor.contacts.name}/${ContactsBottomMenuTab.filterSegment}',
      );
    });

    test('the two are not the same tab, so the remembered one cannot be confused', () {
      expect(_contacts(favoritesFilter: true), isNot(_contacts(favoritesFilter: false)));
    });
  });

  group('the tab a restart lands on', () {
    test('is found by kind even when the layout changed underneath it', () {
      // Someone was on contacts, the deployment then turned the filter on:
      // the saved path names the old screen, and it must still be contacts
      // they come back to rather than whatever tab happens to be first.
      final withFilter = _contacts(favoritesFilter: true);
      final config = BottomMenuConfig(
        tabs: [
          const KeypadBottomMenuTab(
            enabled: true,
            initial: true,
            titleL10n: 'main_BottomNavigationBarItemLabel_keypad',
            icon: Icons.dialpad,
          ),
          withFilter,
        ],
      );

      expect(config.findInitialTab(MainFlavor.contacts.name), same(withFilter));
    });

    test('and by its own path when nothing changed', () {
      final plain = _contacts(favoritesFilter: false);
      final config = BottomMenuConfig(tabs: [plain]);

      expect(config.findInitialTab(plain.routePath), same(plain));
    });
  });
}
