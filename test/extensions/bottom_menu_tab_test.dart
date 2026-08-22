import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';

void main() {
  // The point of the tab-level identity is totality: the flavor-level
  // toNavBarKey throws for embedded, so walking a configured tab list has to
  // go through the tab - and every kind must answer.
  test('every tab kind yields the identity its bar entry is keyed by', () {
    const embedded = EmbeddedBottomMenuTab(
      id: 'help',
      enabled: true,
      initial: false,
      titleL10n: 'Help',
      icon: Icons.help,
    );
    final expectations = <BottomMenuTab, (String, Key)>{
      const FavoritesBottomMenuTab(enabled: true, initial: false, titleL10n: 'f', icon: Icons.star): (
        favoritesNavBarId,
        favoritesNavBarKey,
      ),
      const RecentsBottomMenuTab(
        supportsCallHistory: true,
        enabled: true,
        initial: false,
        titleL10n: 'r',
        icon: Icons.history,
      ): (
        recentsNavBarId,
        recentsNavBarKey,
      ),
      ContactsBottomMenuTab(
        contactSourceTypes: const [],
        layout: ContactsLayout.tabbed,
        favorites: false,
        enabled: true,
        initial: false,
        titleL10n: 'c',
        icon: Icons.people,
      ): (
        contactsNavBarId,
        contactsNavBarKey,
      ),
      const KeypadBottomMenuTab(enabled: true, initial: true, titleL10n: 'k', icon: Icons.dialpad): (
        keypadNavBarId,
        keypadNavBarKey,
      ),
      const MessagingBottomMenuTab(enabled: true, initial: false, titleL10n: 'm', icon: Icons.chat): (
        messagingNavBarId,
        messagingNavBarKey,
      ),
      embedded: (embeddedNavBarId('help'), embeddedNavBarKey('help')),
    };

    for (final MapEntry(key: tab, value: (expectedId, expectedKey)) in expectations.entries) {
      // The id string and the key are pinned each against its own keys.dart
      // declaration - asserting one through the other would hold by
      // construction and guard nothing.
      expect(tab.navBarId, expectedId, reason: tab.titleL10n);
      expect(tab.navBarKey, expectedKey, reason: tab.titleL10n);
    }
  });
}
