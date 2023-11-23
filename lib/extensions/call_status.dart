import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/l10n/localization.dart';

extension CallStatusL10n on CallStatus {
  String l10n(BuildContext context) {
    switch (this) {
      case CallStatus.connectivityNone:
        return context.l10n.callStatus_connectivityNone;
      case CallStatus.connectError:
        return context.l10n.callStatus_connectError;
      case CallStatus.appUnregistered:
        return context.l10n.callStatus_appUnregistered;
      case CallStatus.connectIssue:
        return context.l10n.callStatus_connectIssue;
      case CallStatus.inProgress:
        return context.l10n.callStatus_inProgress;
      case CallStatus.ready:
        return context.l10n.callStatus_ready;
    }
  }
}

extension CallStatusColor on CallStatus {
  Color color(BuildContext context) {
    final themeData = Theme.of(context);
    final colorScheme = themeData.colorScheme;
    switch (this) {
      case CallStatus.connectivityNone:
        return colorScheme.error;
      case CallStatus.connectError:
        return colorScheme.error;
      case CallStatus.appUnregistered:
        return colorScheme.secondaryContainer;
      case CallStatus.connectIssue:
        return colorScheme.error;
      case CallStatus.inProgress:
        return colorScheme.secondary;
      case CallStatus.ready:
        return colorScheme.tertiary;
    }
  }
}
