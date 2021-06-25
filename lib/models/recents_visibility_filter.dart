import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum RecentsVisibilityFilter {
  all,
  missed,
  incoming,
  outgoing,
}

extension RecentsVisibilityFilterI10nExtension on RecentsVisibilityFilter {
  String l10n(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    switch (this) {
      case RecentsVisibilityFilter.all:
        return appLocalizations.recentsVisibilityFilterAll;
      case RecentsVisibilityFilter.missed:
        return appLocalizations.recentsVisibilityFilterMissed;
      case RecentsVisibilityFilter.incoming:
        return appLocalizations.recentsVisibilityFilterIncoming;
      case RecentsVisibilityFilter.outgoing:
        return appLocalizations.recentsVisibilityFilterOutgoing;
      default:
        throw ArgumentError();
    }
  }
}
