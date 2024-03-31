import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';

import 'package:webtrit_phone/features/notifications/models/models.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

class CallUndefinedLineErrorNotification extends ErrorNotification {
  const CallUndefinedLineErrorNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_callUndefinedLine;
  }
}

class CallSignalingClientNotConnectErrorNotification extends ErrorNotification {
  const CallSignalingClientNotConnectErrorNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_callSignalingClientNotConnect;
  }
}

class CallSignalingClientSessionMissedErrorNotification extends ErrorNotification {
  const CallSignalingClientSessionMissedErrorNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_callSignalingClientSessionMissed;
  }
}

class CallConnectErrorNotification extends ErrorNotification {
  const CallConnectErrorNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_callConnect;
  }
}

class CallUserMediaErrorNotification extends ErrorNotification {
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

class AppUnregisteredNotification extends MessageNotification {
  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_appUnregistered;
  }
}

class AppOfflineNotification extends MessageNotification {
  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_appOffline;
  }
}

class AppOnlineNotification extends SuccessNotification {
  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_appOnline;
  }
}
