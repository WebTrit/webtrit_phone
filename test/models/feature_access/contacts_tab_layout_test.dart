import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/models/models.dart';

ContactsBottomMenuTab _contacts({required ContactsLayout layout, bool favorites = true}) => ContactsBottomMenuTab(
  contactSourceTypes: const [ContactSourceType.external],
  layout: layout,
  favorites: favorites,
  enabled: true,
  initial: false,
  titleL10n: 'main_BottomNavigationBarItemLabel_contacts',
  icon: Icons.contacts,
);

void main() {
  group('which contacts screen a deployment gets', () {
    test('a configuration that says nothing keeps the one it has', () {
      expect(_contacts(layout: ContactsLayout.tabbed).layout, ContactsLayout.tabbed);
      expect(_contacts(layout: ContactsLayout.tabbed).routePath, MainFlavor.contacts.name);
    });

    test('the other arrangement is a separate destination', () {
      expect(
        _contacts(layout: ContactsLayout.unified).routePath,
        '${MainFlavor.contacts.name}/${ContactsBottomMenuTab.unifiedSegment}',
      );
    });

    test('and favourites are offered only where there is a place for them', () {
      // The tabbed arrangement keeps favourites in a section of their own, so
      // the flag says nothing there however it is set.
      expect(_contacts(layout: ContactsLayout.unified, favorites: true).offersFavorites, isTrue);
      expect(_contacts(layout: ContactsLayout.unified, favorites: false).offersFavorites, isFalse);
      expect(_contacts(layout: ContactsLayout.tabbed, favorites: true).offersFavorites, isFalse);
    });

    test('the two are not the same tab, so the remembered one cannot be confused', () {
      expect(_contacts(layout: ContactsLayout.unified), isNot(_contacts(layout: ContactsLayout.tabbed)));
    });
  });

  group('the tab a restart lands on', () {
    test('is found by kind even when the layout changed underneath it', () {
      // Someone was on contacts, the deployment then changed arrangement:
      // the saved path names the old screen, and it must still be contacts
      // they come back to rather than whatever tab happens to be first.
      final unified = _contacts(layout: ContactsLayout.unified);
      final config = BottomMenuConfig(
        tabs: [
          const KeypadBottomMenuTab(
            enabled: true,
            initial: true,
            titleL10n: 'main_BottomNavigationBarItemLabel_keypad',
            icon: Icons.dialpad,
          ),
          unified,
        ],
      );

      expect(config.findInitialTab(MainFlavor.contacts.name), same(unified));
    });

    test('and by its own path when nothing changed', () {
      final plain = _contacts(layout: ContactsLayout.tabbed);
      final config = BottomMenuConfig(tabs: [plain]);

      expect(config.findInitialTab(plain.routePath), same(plain));
    });
  });
}
