import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/models/models.dart';

BottomMenuTab _favorites({required bool enabled}) => FavoritesBottomMenuTab(
  enabled: enabled,
  initial: false,
  titleL10n: 'main_BottomNavigationBarItemLabel_favorites',
  icon: Icons.star,
);

BottomMenuTab _contacts({required bool favoritesFilter, bool enabled = true}) => ContactsBottomMenuTab(
  contactSourceTypes: const [ContactSourceType.external],
  favoritesFilter: favoritesFilter,
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
      final config = BottomMenuConfig(tabs: [_favorites(enabled: true), _contacts(favoritesFilter: false)]);

      expect(config.favoritesReachable, isTrue);
    });

    test('and when the contacts list filters by them instead', () {
      // The arrangement this install ships: no section, a star on the
      // contacts screen. Marking someone has to stay possible, or the filter
      // is a control over a list nobody can fill.
      final config = BottomMenuConfig(tabs: [_favorites(enabled: false), _contacts(favoritesFilter: true)]);

      expect(config.favoritesReachable, isTrue);
    });
  });

  group('favourites are out of reach', () {
    test('when the section is off and the list does not filter by them', () {
      final config = BottomMenuConfig(tabs: [_favorites(enabled: false), _contacts(favoritesFilter: false)]);

      expect(config.favoritesReachable, isFalse);
    });

    test('and when the contacts tab that would filter is itself off', () {
      final config = BottomMenuConfig(
        tabs: [_favorites(enabled: false), _contacts(favoritesFilter: true, enabled: false)],
      );

      expect(config.favoritesReachable, isFalse);
    });
  });
}
