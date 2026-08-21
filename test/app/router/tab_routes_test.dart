import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/models/models.dart';

ContactsBottomMenuTab _tab({required bool favoritesFilter}) => ContactsBottomMenuTab(
  contactSourceTypes: const [ContactSourceType.external],
  favoritesFilter: favoritesFilter,
  enabled: true,
  initial: true,
  titleL10n: 'main_BottomNavigationBarItemLabel_contacts',
  icon: Icons.contacts,
);

RecentsBottomMenuTab _recentsTab({required bool supportsCallHistory}) => RecentsBottomMenuTab(
  supportsCallHistory: supportsCallHistory,
  enabled: true,
  initial: true,
  titleL10n: 'main_BottomNavigationBarItemLabel_recents',
  icon: Icons.history,
);

void main() {
  group('where a contacts tab leads', () {
    test('a tab that says nothing lands on the screen it always had', () {
      final route = contactsRouteOf(_tab(favoritesFilter: false));

      expect(route.initialChildren?.single.routeName, ContactsScreenPageRoute.name);
    });

    test('a tab that offers the favourites filter lands on the other screen', () {
      final route = contactsRouteOf(_tab(favoritesFilter: true));

      expect(route.initialChildren?.single.routeName, ContactsFilterScreenPageRoute.name);
    });

    test('the screen is always named, never left to the router to guess', () {
      // The contacts router has a default child, so a route built without
      // children silently lands on it - which is the wrong screen for half
      // the deployments and only shows up by running the app.
      for (final favoritesFilter in [false, true]) {
        final route = contactsRouteOf(_tab(favoritesFilter: favoritesFilter));

        expect(route.initialChildren, isNotEmpty, reason: 'favoritesFilter: $favoritesFilter');
      }
    });
  });

  group('where a recents tab leads', () {
    // Asked in two places as well - the tab set and the initial tab - and the
    // two are the same answer or one of them opens the wrong history.
    test('a tab without call history lands on the plain recents screen', () {
      expect(recentsRouteOf(_recentsTab(supportsCallHistory: false)).routeName, RecentsRouterPageRoute.name);
    });

    test('a tab with call history lands on the one that shows it', () {
      expect(recentsRouteOf(_recentsTab(supportsCallHistory: true)).routeName, RecentCdrsRouterPageRoute.name);
    });
  });
}
