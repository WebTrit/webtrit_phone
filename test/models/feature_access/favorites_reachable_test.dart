import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/models/models.dart';

BottomMenuTab _favorites({required bool enabled}) => FavoritesBottomMenuTab(
  enabled: enabled,
  initial: false,
  titleL10n: 'main_BottomNavigationBarItemLabel_favorites',
  icon: Icons.star,
);

BottomMenuTab _contacts({required ContactsLayout layout, bool favorites = true, bool enabled = true}) =>
    ContactsBottomMenuTab(
      contactSourceTypes: const [ContactSourceType.external],
      layout: layout,
      favorites: favorites,
      enabled: enabled,
      initial: true,
      titleL10n: 'main_BottomNavigationBarItemLabel_contacts',
      icon: Icons.contacts,
    );

/// Whether favourites are reachable decides whether marking one is offered at
/// all. The two arrangements are configured separately, so this is the one
/// question both of them answer.
void main() {
  group('favourites are reachable', () {
    test('when they have a section of their own', () {
      final config = BottomMenuConfig(
        tabs: [
          _favorites(enabled: true),
          _contacts(layout: ContactsLayout.tabbed),
        ],
      );

      expect(config.favoritesReachable, isTrue);
    });

    test('and when the contacts list filters by them instead', () {
      // The arrangement this install ships: no section, a star on the
      // contacts screen. Marking someone has to stay possible, or the filter
      // is a control over a list nobody can fill.
      final config = BottomMenuConfig(
        tabs: [
          _favorites(enabled: false),
          _contacts(layout: ContactsLayout.unified),
        ],
      );

      expect(config.favoritesReachable, isTrue);
    });
    test('but not when that list is told to leave them out', () {
      // The arrangement has a place for favourites and the deployment chose
      // not to use it: nothing shows them, so nothing offers to mark one.
      final config = BottomMenuConfig(
        tabs: [
          _favorites(enabled: false),
          _contacts(layout: ContactsLayout.unified, favorites: false),
        ],
      );

      expect(config.favoritesReachable, isFalse);
    });
  });

  group('favourites are out of reach', () {
    test('when the section is off and the list does not filter by them', () {
      final config = BottomMenuConfig(
        tabs: [
          _favorites(enabled: false),
          _contacts(layout: ContactsLayout.tabbed),
        ],
      );

      expect(config.favoritesReachable, isFalse);
    });

    test('and when the contacts tab that would filter is itself off', () {
      final config = BottomMenuConfig(
        tabs: [
          _favorites(enabled: false),
          _contacts(layout: ContactsLayout.unified, favorites: true, enabled: false),
        ],
      );

      expect(config.favoritesReachable, isFalse);
    });
  });
}
