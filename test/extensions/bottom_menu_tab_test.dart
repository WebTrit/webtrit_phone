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
    final expectations = <BottomMenuTab, Key>{
      const FavoritesBottomMenuTab(enabled: true, initial: false, titleL10n: 'f', icon: Icons.star): favoritesNavBarKey,
      const RecentsBottomMenuTab(
        supportsCallHistory: true,
        enabled: true,
        initial: false,
        titleL10n: 'r',
        icon: Icons.history,
      ): recentsNavBarKey,
      ContactsBottomMenuTab(
        contactSourceTypes: const [],
        enabled: true,
        initial: false,
        titleL10n: 'c',
        icon: Icons.people,
      ): contactsNavBarKey,
      const KeypadBottomMenuTab(enabled: true, initial: true, titleL10n: 'k', icon: Icons.dialpad): keypadNavBarKey,
      const MessagingBottomMenuTab(enabled: true, initial: false, titleL10n: 'm', icon: Icons.chat): messagingNavBarKey,
      embedded: embeddedNavBarKey('help'),
    };

    for (final MapEntry(key: tab, value: expectedKey) in expectations.entries) {
      expect(tab.navBarKey, expectedKey, reason: tab.titleL10n);
      expect(Key(tab.navBarId), expectedKey, reason: tab.titleL10n);
    }
  });
}
