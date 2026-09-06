import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

extension ReadStatusExtensions on ReadStatus {
  /// Returns the localized label for toggling the read status.
  String toggleActionLabelL10n(BuildContext context) =>
      isRead ? context.l10n.voicemail_Label_markAsNew : context.l10n.voicemail_Label_markAsHeard;

  /// Indicates if a "new" status indicator should be shown.
  bool get showBadge => isRead;

  /// Returns the opposite status if applicable.
  ReadStatus get toggled {
    if (isRead) {
      return ReadStatus.unread;
    } else if (isUnread) {
      return ReadStatus.read;
    } else {
      throw Exception('Cannot toggle status for unknown read status');
    }
  }
}
