import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/styles/styles.dart';

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

    final callStatusStyles = themeData.extension<CallStatusStyles>()?.primary;

    switch (this) {
      case CallStatus.connectivityNone:
        return callStatusStyles?.connectivityNone ?? colorScheme.error;
      case CallStatus.connectError:
        return callStatusStyles?.connectError ?? colorScheme.error;
      case CallStatus.appUnregistered:
        return callStatusStyles?.appUnregistered ?? colorScheme.onSurfaceVariant;
      case CallStatus.connectIssue:
        return callStatusStyles?.connectIssue ?? colorScheme.error;
      case CallStatus.inProgress:
        return callStatusStyles?.ready ?? colorScheme.secondary;
      case CallStatus.ready:
        return callStatusStyles?.ready ?? colorScheme.tertiary;
    }
  }
}
