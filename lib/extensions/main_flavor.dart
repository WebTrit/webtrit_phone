import 'package:flutter/foundation.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/models/main_flavor.dart';

extension LoginTypeLoginSegmentKey on MainFlavor {
  /// Widget key of the bottom navigation entry of a KNOWN fixed section -
  /// the way the E2E flows address them by constant. Code that walks a
  /// configured tab list must use the total `tab.navBarKey` instead: an
  /// embedded section has no key of its kind (an install can carry several),
  /// so that arm can only throw.
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
