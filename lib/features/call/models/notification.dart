import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';

import 'package:webtrit_phone/app/notifications/models/notification.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

final class CallUndefinedLineErrorNotification extends ErrorNotification {
  const CallUndefinedLineErrorNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_callUndefinedLine;
  }
}

final class CallSignalingClientNotConnectErrorNotification extends ErrorNotification {
  const CallSignalingClientNotConnectErrorNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_callSignalingClientNotConnect;
  }
}

final class CallSignalingClientSessionMissedErrorNotification extends ErrorNotification {
  const CallSignalingClientSessionMissedErrorNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_callSignalingClientSessionMissed;
  }
}

final class CallConnectErrorNotification extends ErrorNotification {
  const CallConnectErrorNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_callConnect;
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

final class SipServerUnavailable extends ErrorNotification {
  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_sipServiceUnavailable;
  }
}

final class AppUnregisteredNotification extends MessageNotification {
  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_appUnregistered;
  }
}

final class AppOfflineNotification extends MessageNotification {
  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_appOffline;
  }

  @override
  List<NotificationScope> scopes() => [
        NotificationScope.main,
      ];
}

final class AppOnlineNotification extends SuccessNotification {
  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_appOnline;
  }

  @override
  List<NotificationScope> scopes() => [
        NotificationScope.main,
      ];
}

final class ActiveLineBlindTransferWarningNotification extends MessageNotification {
  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_activeLineBlindTransferWarning;
  }
}
