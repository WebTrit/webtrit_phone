import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:auto_route/auto_route.dart';

import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/app/notifications/models/notification.dart';
import 'package:webtrit_phone/app/notifications/models/error_field.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

@Deprecated.instantiate('will be removed, (see [app/notifications/models/notification.dart] for details)')
final class SignalingSessionMissedNotification extends ErrorNotification {
  SignalingSessionMissedNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_SignalingSessionMissed;
  }
}

@Deprecated.instantiate('will be removed, (see [app/notifications/models/notification.dart] for details)')
final class SignalingConnectFailedNotification extends ErrorNotification {
  SignalingConnectFailedNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_SignalingConnectFailed;
  }
}

@Deprecated.instantiate('will be removed, (see [app/notifications/models/notification.dart] for details)')
final class SignalingDisconnectNotification extends ErrorNotification {
  SignalingDisconnectNotification({required this.knownCode, this.systemCode, this.systemReason});

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

final class CallUserMediaErrorNotification extends MessageNotification {
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

final class CallMediaTrackSetupErrorNotification extends MessageNotification {
  const CallMediaTrackSetupErrorNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_callMediaTrackSetup;
  }

  @override
  SnackBarAction? action(BuildContext context) => null;
}

@Deprecated.instantiate('will be removed, (see [app/notifications/models/notification.dart] for details)')
final class CallSdpConfigurationErrorNotification extends ErrorNotification {
  CallSdpConfigurationErrorNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBarAction_callSdpConfiguration;
  }
}

@Deprecated.instantiate('will be removed, (see [app/notifications/models/notification.dart] for details)')
final class CallUndefinedLineNotification extends ErrorNotification {
  CallUndefinedLineNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_callUndefinedLine;
  }
}

final class CallServiceBusyLineNotification extends MessageNotification {
  const CallServiceBusyLineNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_callServiceBusyLine;
  }
}

final class CallWhileOfflineNotification extends MessageNotification {
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

final class GeneralUnableToCallNotification extends MessageNotification {
  const GeneralUnableToCallNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_generalUnableToCall;
  }
}

final class CallRejectedNotification extends MessageNotification {
  @override
  String l10n(BuildContext context) {
    return context.l10n.signalingResponseCode_rejected;
  }
}

final class CallUnwantedNotification extends MessageNotification {
  @override
  String l10n(BuildContext context) {
    return context.l10n.signalingResponseCode_unwanted;
  }
}

final class CallUserNotExistNotification extends MessageNotification {
  @override
  String l10n(BuildContext context) {
    return context.l10n.signalingResponseCode_userNotExist;
  }
}

final class CallBusyNotification extends MessageNotification {
  @override
  String l10n(BuildContext context) {
    return context.l10n.signalingResponseCode_userBusy;
  }
}

final class CallInvalidNumberNotification extends MessageNotification {
  @override
  String l10n(BuildContext context) {
    return context.l10n.signalingResponseCode_invalidNumberFormat;
  }
}

@Deprecated.instantiate('will be removed, (see [app/notifications/models/notification.dart] for details)')
final class SipRegistrationFailedNotification extends ErrorNotification {
  SipRegistrationFailedNotification({required this.knownCode, this.systemCode, this.systemReason});

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

// final class AppOfflineNotification extends MessageNotification {
//   @override
//   String l10n(BuildContext context) {
//     return context.l10n.notifications_messageSnackBar_appOffline;
//   }

//   @override
//   List<NotificationScope> scopes() => [NotificationScope.main];
// }

// final class AppOnlineNotification extends SuccessNotification {
//   @override
//   String l10n(BuildContext context) {
//     return context.l10n.notifications_successSnackBar_appOnline;
//   }

//   @override
//   List<NotificationScope> scopes() => [NotificationScope.main];
// }

final class ActiveLineBlindTransferWarningNotification extends MessageNotification {
  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_activeLineBlindTransferWarning;
  }
}

final class BlindTransferFailedNotification extends MessageNotification {
  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_blindTransferFailed;
  }
}

@Deprecated.instantiate('will be removed, (see [app/notifications/models/notification.dart] for details)')
final class CallErrorRegisteringSelfManagedPhoneAccountNotification extends ErrorNotification {
  CallErrorRegisteringSelfManagedPhoneAccountNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.call_errorRegisteringSelfManagedPhoneAccount;
  }
}
