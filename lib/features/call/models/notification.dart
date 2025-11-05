import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:auto_route/auto_route.dart';

import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/app/notifications/models/notification.dart';
import 'package:webtrit_phone/app/notifications/models/error_field.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

final class SignalingSessionMissedNotification extends ErrorNotification {
  const SignalingSessionMissedNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_SignalingSessionMissed;
  }
}

final class SignalingConnectFailedNotification extends ErrorNotification {
  const SignalingConnectFailedNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_SignalingConnectFailed;
  }
}

final class SignalingDisconnectNotification extends ErrorNotification {
  const SignalingDisconnectNotification({required this.knownCode, this.systemCode, this.systemReason});

  final SignalingDisconnectCode knownCode;
  final int? systemCode;
  final String? systemReason;

  @override
  String l10n(BuildContext context) {
    if (systemReason != null) {
      return context.l10n.notifications_errorSnackBar_signalingDisconnectWithSystemReason(systemReason!);
    }
    return context.l10n.notifications_errorSnackBar_signalingDisconnectWithCodeName(knownCode.name);
  }

  @override
  SnackBarAction action(BuildContext context) {
    final title = l10n(context);
    final errorFields = [
      ErrorFieldModel(context.l10n.default_ErrorMessage, title),
      ErrorFieldModel(context.l10n.request_StatusName, knownCode.name),
      ErrorFieldModel(context.l10n.request_StatusCode, systemCode?.toString() ?? 'N/A'),
      ErrorFieldModel(context.l10n.default_ErrorDetails, systemReason ?? 'N/A'),
    ];

    return SnackBarAction(
      label: context.l10n.default_ErrorDetails,
      onPressed: () {
        context.router.push(ErrorDetailsScreenPageRoute(title: title, fields: errorFields));
      },
    );
  }
}

final class CallUserMediaErrorNotification extends ErrorNotification {
  const CallUserMediaErrorNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_callUserMedia;
  }

  @override
  SnackBarAction? action(BuildContext context) {
    return SnackBarAction(
      label: context.l10n.notifications_errorSnackBarAction_callUserMedia,
      onPressed: () => openAppSettings(),
    );
  }
}

final class CallSdpConfigurationErrorNotification extends ErrorNotification {
  const CallSdpConfigurationErrorNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBarAction_callSdpConfiguration;
  }
}

final class CallUndefinedLineNotification extends ErrorNotification {
  const CallUndefinedLineNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_callUndefinedLine;
  }
}

final class CallWhileOfflineNotification extends ErrorNotification {
  const CallWhileOfflineNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_callWhileOffline;
  }
}

final class CallWhileUnregisteredNotification extends MessageNotification {
  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_callWhileUnregistered;
  }
}

final class CallNegotiationTimeoutNotification extends MessageNotification {
  const CallNegotiationTimeoutNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_callNegotiationTimeout;
  }
}

final class SipRegistrationFailedNotification extends ErrorNotification {
  const SipRegistrationFailedNotification({required this.knownCode, this.systemCode, this.systemReason});

  final SignalingRegistrationFailedCode knownCode;
  final int? systemCode;
  final String? systemReason;

  @override
  String l10n(BuildContext context) {
    switch (knownCode) {
      case SignalingRegistrationFailedCode.sipServerUnavailable:
        return context.l10n.notifications_errorSnackBar_sipRegistrationFailed_Unavailable;
      default:
        if (systemReason != null) {
          return context.l10n.notifications_errorSnackBar_sipRegistrationFailed_WithSystemReason(systemReason!);
        } else {
          return context.l10n.notifications_errorSnackBar_sipRegistrationFailed_Unexpected;
        }
    }
  }

  @override
  SnackBarAction action(BuildContext context) {
    final title = l10n(context);
    final errorFields = [
      ErrorFieldModel(context.l10n.default_ErrorMessage, title),
      ErrorFieldModel(context.l10n.request_StatusName, knownCode.name),
      ErrorFieldModel(context.l10n.request_StatusCode, systemCode?.toString() ?? 'N/A'),
      ErrorFieldModel(context.l10n.default_ErrorDetails, systemReason ?? 'N/A'),
    ];

    return SnackBarAction(
      label: context.l10n.default_ErrorDetails,
      onPressed: () {
        context.router.push(ErrorDetailsScreenPageRoute(title: title, fields: errorFields));
      },
    );
  }
}

final class AppOfflineNotification extends MessageNotification {
  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_messageSnackBar_appOffline;
  }

  @override
  List<NotificationScope> scopes() => [NotificationScope.main];
}

final class AppOnlineNotification extends SuccessNotification {
  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_successSnackBar_appOnline;
  }

  @override
  List<NotificationScope> scopes() => [NotificationScope.main];
}

final class ActiveLineBlindTransferWarningNotification extends MessageNotification {
  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_activeLineBlindTransferWarning;
  }
}
