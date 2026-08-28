import 'package:flutter/foundation.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/models/main_flavor.dart';

/// Which section of the main screen a tab route belongs to, or `null` when the
/// route is not one of its tabs.
///
/// A section can be reached by more than one route: the recents tab opens the
/// call history when the backend can answer for it and the plain list
/// otherwise, and both are the same tab to everything outside the router.
MainFlavor? mainFlavorOfTabRoute(String routeName) {
  switch (routeName) {
    case FavoritesRouterPageRoute.name:
      return MainFlavor.favorites;
    case RecentsRouterPageRoute.name:
    case RecentCdrsRouterPageRoute.name:
      return MainFlavor.recents;
    case ContactsRouterPageRoute.name:
      return MainFlavor.contacts;
    case KeypadScreenPageRoute.name:
      return MainFlavor.keypad;
    case ConversationsScreenPageRoute.name:
      return MainFlavor.messaging;
    case VoicemailTabPageRoute.name:
      return MainFlavor.voicemail;
    case EmbeddedTabPageRoute.name:
      return MainFlavor.embedded;
    default:
      return null;
  }
}

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
      MainFlavor.voicemail => voicemailNavBarKey,
      // An embedded tab carries no key of its kind: several sections can be
      // configured at once, and each entry is keyed by its section id via
      // embeddedNavBarKey(id) in lib/app/keys.dart.
      MainFlavor.embedded => throw UnsupportedError('embedded tabs are keyed by section id: use embeddedNavBarKey(id)'),
    };
  }
}
