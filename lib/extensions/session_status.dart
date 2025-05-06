import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/styles/styles.dart';

extension SessionStatusL10n on SessionStatus {
  String l10n(BuildContext context) {
    switch (this) {
      case SessionStatus.connectivityNone:
        return context.l10n.callStatus_connectivityNone;
      case SessionStatus.connectError:
        return context.l10n.callStatus_connectError;
      case SessionStatus.appUnregistered:
        return context.l10n.callStatus_appUnregistered;
      case SessionStatus.connectIssue:
        return context.l10n.callStatus_connectIssue;
      case SessionStatus.inProgress:
        return context.l10n.callStatus_inProgress;
      case SessionStatus.ready:
        return context.l10n.callStatus_ready;
      case SessionStatus.pushTokenError:
        return context.l10n.sessionStatus_pushNotificationServiceProblem;
    }
  }
}

extension SessionStatusColor on SessionStatus {
  Color color(BuildContext context) {
    final themeData = Theme.of(context);
    final colorScheme = themeData.colorScheme;
    final callStatusStyles = themeData.extension<CallStatusStyles>()?.primary;

    switch (this) {
      case SessionStatus.connectivityNone:
        return callStatusStyles?.connectivityNone ?? colorScheme.error;
      case SessionStatus.connectError:
        return callStatusStyles?.connectError ?? colorScheme.error;
      case SessionStatus.appUnregistered:
        return callStatusStyles?.appUnregistered ?? colorScheme.onSurfaceVariant;
      case SessionStatus.connectIssue:
        return callStatusStyles?.connectIssue ?? colorScheme.error;
      case SessionStatus.inProgress:
        return callStatusStyles?.ready ?? colorScheme.secondary;
      case SessionStatus.ready:
        return callStatusStyles?.ready ?? colorScheme.tertiary;
      case SessionStatus.pushTokenError:
        // TODO(Serdun): Move color to the color scheme
        return Colors.orange;
    }
  }
}

extension SessionStatusKey on SessionStatus {
  Key get key {
    switch (this) {
      case SessionStatus.connectivityNone:
        return const Key('session_status_connectivityNone');
      case SessionStatus.connectError:
        return const Key('session_status_connectError');
      case SessionStatus.appUnregistered:
        return const Key('session_status_appUnregistered');
      case SessionStatus.connectIssue:
        return const Key('session_status_connectIssue');
      case SessionStatus.inProgress:
        return const Key('session_status_inProgress');
      case SessionStatus.ready:
        return const Key('session_status_ready');
      case SessionStatus.pushTokenError:
        return const Key('session_status_pushTokenError');
    }
  }
}
