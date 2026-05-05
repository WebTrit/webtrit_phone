import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/styles/styles.dart';

extension SessionStatusL10n on SessionStatus {
  String l10n(BuildContext context) {
    if (hasPushTokenError) return context.l10n.sessionStatus_pushNotificationServiceProblem;
    return switch (signalingStatus) {
      CallStatus.connectivityNone => context.l10n.callStatus_connectivityNone,
      CallStatus.connectError => context.l10n.callStatus_connectError,
      CallStatus.appUnregistered => context.l10n.callStatus_appUnregistered,
      CallStatus.connectIssue => context.l10n.callStatus_connectIssue,
      CallStatus.inProgress => context.l10n.callStatus_inProgress,
      CallStatus.ready => context.l10n.callStatus_ready,
    };
  }

  // Only called from MainAppBar when isEstablishing is true, so hasPushTokenError
  // is always false at call site — no push token branch needed here.
  String appBarl10n(BuildContext context) {
    return switch (signalingStatus) {
      CallStatus.connectivityNone => context.l10n.sessionStatus_AppBar_waitingForNetwork,
      CallStatus.connectError || CallStatus.connectIssue => context.l10n.sessionStatus_AppBar_waitingForConnection,
      CallStatus.appUnregistered => context.l10n.sessionStatus_AppBar_disconnected,
      CallStatus.inProgress => context.l10n.sessionStatus_AppBar_connecting,
      CallStatus.ready => '_',
    };
  }
}

extension SessionStatusColor on SessionStatus {
  Color color(BuildContext context) {
    final themeData = Theme.of(context);
    final colorScheme = themeData.colorScheme;
    final callStatusStyles = themeData.extension<CallStatusStyles>()?.primary;

    if (hasPushTokenError) return callStatusStyles?.connectIssue ?? colorScheme.error;

    return switch (signalingStatus) {
      CallStatus.connectivityNone => callStatusStyles?.connectivityNone ?? colorScheme.error,
      CallStatus.connectError => callStatusStyles?.connectError ?? colorScheme.error,
      CallStatus.appUnregistered => callStatusStyles?.appUnregistered ?? colorScheme.onSurfaceVariant,
      CallStatus.connectIssue => callStatusStyles?.connectIssue ?? colorScheme.error,
      CallStatus.inProgress => callStatusStyles?.inProgress ?? colorScheme.secondary,
      CallStatus.ready => callStatusStyles?.ready ?? colorScheme.tertiary,
    };
  }
}

extension SessionStatusKey on SessionStatus {
  Key get key {
    if (hasPushTokenError) return const Key('session_status_pushTokenError');
    return switch (signalingStatus) {
      CallStatus.connectivityNone => const Key('session_status_connectivityNone'),
      CallStatus.connectError => const Key('session_status_connectError'),
      CallStatus.appUnregistered => const Key('session_status_appUnregistered'),
      CallStatus.connectIssue => const Key('session_status_connectIssue'),
      CallStatus.inProgress => const Key('session_status_inProgress'),
      CallStatus.ready => const Key('session_status_ready'),
    };
  }
}
