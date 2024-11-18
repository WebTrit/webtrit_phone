import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../models/models.dart';

extension PushTokenStatusTypeL10n on PushTokenStatusType {
  String title(BuildContext context) {
    switch (this) {
      case PushTokenStatusType.success:
        return context.l10n.diagnostic_pushTokenStatusType_success;
      case PushTokenStatusType.error:
        return context.l10n.sessionStatus_pushNotificationServiceProblem;
      case PushTokenStatusType.progress:
        return context.l10n.diagnostic_pushTokenStatusType_progress;
    }
  }
}
