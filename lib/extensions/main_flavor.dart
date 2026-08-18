import 'package:flutter/foundation.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/models/main_flavor.dart';

extension LoginTypeLoginSegmentKey on MainFlavor {
  /// Stable automation id of the bottom navigation entry that opens this
  /// section; the visible caption is configured per install and translated.
  ///
  /// For a KNOWN fixed section only (the way the E2E flows address them).
  /// An embedded section is not named here: there can be several of them, and
  /// they are told apart by the id each is configured with. Code that walks a
  /// configured tab list must use the total `tab.navBarId` / `tab.navBarKey`
  /// instead of this - here the embedded arms are dead ends.
  String toNavBarId() {
    return switch (this) {
      MainFlavor.favorites => favoritesNavBarId,
      MainFlavor.recents => recentsNavBarId,
      MainFlavor.contacts => contactsNavBarId,
      MainFlavor.keypad => keypadNavBarId,
      MainFlavor.messaging => messagingNavBarId,
      MainFlavor.embedded => embeddedNavBarIdPrefix,
    };
  }

  Key toNavBarKey() {
    return switch (this) {
      MainFlavor.favorites => favoritesNavBarKey,
      MainFlavor.recents => recentsNavBarKey,
      MainFlavor.contacts => contactsNavBarKey,
      MainFlavor.keypad => keypadNavBarKey,
      MainFlavor.messaging => messagingNavBarKey,
      // An embedded tab carries no key of its kind: several sections can be
      // configured at once, and each entry is keyed by its section id via
      // embeddedNavBarKey(id) in lib/app/keys.dart.
      MainFlavor.embedded => throw UnsupportedError('embedded tabs are keyed by section id: use embeddedNavBarKey(id)'),
    };
  }
}
