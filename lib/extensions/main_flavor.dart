import 'package:flutter/foundation.dart';
import 'package:webtrit_phone/models/main_flavor.dart';

extension LoginTypeLoginSegmentKey on MainFlavor {
  Key toNavBarKey() {
    return switch (this) {
      MainFlavor.favorites => const Key('favoritesNavBarKey'),
      MainFlavor.recents => const Key('recentsNavBarKey'),
      MainFlavor.contacts => const Key('contactsNavBarKey'),
      MainFlavor.keypad => const Key('keypadNavBarKey'),
      MainFlavor.messaging => const Key('messagingNavBarKey'),
      // An embedded tab carries no key of its kind: several sections can be
      // configured at once, and each entry is keyed by its section id via
      // embeddedNavBarKey(id) in lib/app/keys.dart.
      MainFlavor.embedded => throw UnsupportedError('embedded tabs are keyed by section id: use embeddedNavBarKey(id)'),
    };
  }
}
