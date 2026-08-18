import 'package:flutter/widgets.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/models/models.dart';

/// Identity of a tab's navigation bar entry, total over every tab kind.
///
/// The flavor-level `MainFlavor.toNavBarKey` cannot name an
/// embedded entry - an install can carry several of them - so anything that
/// walks a configured tab list must key entries through the tab itself.
///
/// Both switches enumerate the sealed hierarchy without a wildcard on
/// purpose: a new tab kind must state its identity here or fail to compile,
/// rather than silently inherit one and collide with a sibling.
extension BottomMenuTabNavBarX on BottomMenuTab {
  /// Stable automation id of this tab's bottom navigation entry, as declared
  /// in `keys.dart`.
  String get navBarId => switch (this) {
    FavoritesBottomMenuTab() => favoritesNavBarId,
    RecentsBottomMenuTab() => recentsNavBarId,
    ContactsBottomMenuTab() => contactsNavBarId,
    KeypadBottomMenuTab() => keypadNavBarId,
    MessagingBottomMenuTab() => messagingNavBarId,
    EmbeddedBottomMenuTab(:final id) => embeddedNavBarId(id),
  };

  /// Widget key of the same entry - the canonical constants and builders of
  /// `keys.dart`, so the id-key pairing stays owned in one place.
  Key get navBarKey => switch (this) {
    FavoritesBottomMenuTab() => favoritesNavBarKey,
    RecentsBottomMenuTab() => recentsNavBarKey,
    ContactsBottomMenuTab() => contactsNavBarKey,
    KeypadBottomMenuTab() => keypadNavBarKey,
    MessagingBottomMenuTab() => messagingNavBarKey,
    EmbeddedBottomMenuTab(:final id) => embeddedNavBarKey(id),
  };
}
