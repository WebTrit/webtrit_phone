import 'package:flutter/material.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

extension OutboxMessageFailurel10n on OutboxMessageFailure {
  String l10n(BuildContext context) {
    switch (this) {
      case OutboxMessageFailure.mediaError:
        return context.l10n.outboxMessageFailureMediaError;
      case OutboxMessageFailure.uploadError:
        return context.l10n.outboxMessageFailureUploadError;
    }
  }
}
