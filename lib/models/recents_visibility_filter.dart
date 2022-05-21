import 'package:flutter/widgets.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

enum RecentsVisibilityFilter {
  all,
  missed,
  incoming,
  outgoing,
}

extension RecentsVisibilityFilterI10nExtension on RecentsVisibilityFilter {
  String l10n(BuildContext context) {
    switch (this) {
      case RecentsVisibilityFilter.all:
        return context.l10n.recentsVisibilityFilter_all;
      case RecentsVisibilityFilter.missed:
        return context.l10n.recentsVisibilityFilter_missed;
      case RecentsVisibilityFilter.incoming:
        return context.l10n.recentsVisibilityFilter_incoming;
      case RecentsVisibilityFilter.outgoing:
        return context.l10n.recentsVisibilityFilter_outgoing;
      default:
        throw ArgumentError();
    }
  }
}
