import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';

void main() {
  // Which filters a build shows is configured, so every one of them must be
  // addressable - a switch without a default is what keeps that true when a
  // filter is added.
  test('every recents filter names the tab that applies it', () {
    final expectations = {
      RecentsVisibilityFilter.all: recentsTabAllId,
      RecentsVisibilityFilter.missed: recentsTabMissedId,
      RecentsVisibilityFilter.incoming: recentsTabIncomingId,
      RecentsVisibilityFilter.outgoing: recentsTabOutgoingId,
    };

    expect(expectations.keys, containsAll(RecentsVisibilityFilter.values));
    for (final MapEntry(key: filter, value: id) in expectations.entries) {
      expect(filter.tabId, id, reason: filter.name);
      expect(filter.tabKey, Key(id), reason: filter.name);
    }
  });
}
