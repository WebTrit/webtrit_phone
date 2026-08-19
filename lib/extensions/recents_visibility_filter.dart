import 'package:flutter/foundation.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/models/models.dart';

/// Identity of the tab that applies this filter, in the recents section.
///
/// Which filters a build shows is configured, so a flow can only address a tab
/// by the filter behind it - the captions are translated and their positions
/// move with the configuration.
extension RecentsVisibilityFilterTabX on RecentsVisibilityFilter {
  /// Stable automation id of this filter's tab.
  String get tabId => switch (this) {
    RecentsVisibilityFilter.all => recentsTabAllId,
    RecentsVisibilityFilter.missed => recentsTabMissedId,
    RecentsVisibilityFilter.incoming => recentsTabIncomingId,
    RecentsVisibilityFilter.outgoing => recentsTabOutgoingId,
  };

  /// Widget key of the same tab, from the same declaration in `keys.dart`.
  Key get tabKey => Key(tabId);
}
