import 'package:flutter/foundation.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/models/models.dart';

/// Identity of the tab that applies this filter, in the recents section.
///
/// Which filters a screen shows comes from its configuration, so a flow can
/// only address a tab by the filter behind it - the captions are translated
/// and their positions move with that list. Today both screens show `all` and
/// `missed`; the mapping covers every filter so a wider list needs no edit
/// here (and cannot compile without one when a filter is added).
extension RecentsVisibilityFilterTabX on RecentsVisibilityFilter {
  /// Stable automation id of this filter's tab.
  String get tabId => switch (this) {
    RecentsVisibilityFilter.all => recentsTabAllId,
    RecentsVisibilityFilter.missed => recentsTabMissedId,
    RecentsVisibilityFilter.incoming => recentsTabIncomingId,
    RecentsVisibilityFilter.outgoing => recentsTabOutgoingId,
  };

  /// Widget key of the same tab - the constants themselves, so the widget
  /// test anchor and the accessibility anchor cannot drift apart. Enumerated
  /// like [tabId]: a filter added later must state both or fail to compile.
  Key get tabKey => switch (this) {
    RecentsVisibilityFilter.all => recentsTabAllKey,
    RecentsVisibilityFilter.missed => recentsTabMissedKey,
    RecentsVisibilityFilter.incoming => recentsTabIncomingKey,
    RecentsVisibilityFilter.outgoing => recentsTabOutgoingKey,
  };
}
