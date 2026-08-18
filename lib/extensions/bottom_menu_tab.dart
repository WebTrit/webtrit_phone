import 'package:flutter/widgets.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/models/models.dart';

import 'main_flavor.dart';

/// Identity of a tab's navigation bar entry, total over every tab kind.
///
/// The flavor-level [LoginTypeLoginSegmentKey.toNavBarId] cannot name an
/// embedded entry - an install can carry several of them - so anything that
/// walks a configured tab list must key entries through the tab itself.
extension BottomMenuTabNavBarX on BottomMenuTab {
  /// Stable automation id of this tab's bottom navigation entry.
  String get navBarId => switch (this) {
    EmbeddedBottomMenuTab(:final id) => embeddedNavBarId(id),
    _ => flavor.toNavBarId(),
  };

  /// Widget key of the same entry, built from [navBarId] the way every nav
  /// bar key in `keys.dart` is.
  Key get navBarKey => Key(navBarId);
}
