import 'package:flutter/foundation.dart';
import 'package:webtrit_phone/models/main_flavor.dart';

extension LoginTypeLoginSegmentKey on MainFlavor {
  Key toNavBarKey() {
    return switch (this) {
      MainFlavor.favorites => const Key('favoritesNavBarKey'),
      MainFlavor.recents => const Key('recentsNavBarKey'),
      MainFlavor.recentCdrs => const Key('recentCdrsNavBarKey'),
      MainFlavor.contacts => const Key('contactsNavBarKey'),
      MainFlavor.keypad => const Key('keypadNavBarKey'),
      MainFlavor.messaging => const Key('messagingNavBarKey'),
      MainFlavor.embedded => const Key('embeddedNavBarKey'),
    };
  }
}
