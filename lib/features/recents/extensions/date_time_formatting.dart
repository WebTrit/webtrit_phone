import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

extension DateTimeFormatting on DateTime {
  String format(BuildContext context) {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    if (midnight.isBefore(this)) {
      return context.l10n.recentTimeBeforeMidnight(this);
    } else {
      return context.l10n.recentTimeAfterMidnight(this);
    }
  }
}
