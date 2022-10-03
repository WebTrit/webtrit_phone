import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

@immutable
abstract class Notification {
  const Notification();

  String l10n(BuildContext context);

  SnackBarAction? action(BuildContext context) => null;
}

class CallUndefinedLineErrorNotification extends Notification {
  const CallUndefinedLineErrorNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_callUndefinedLine;
  }
}

class CallSignalingClientNotConnectErrorNotification extends Notification {
  const CallSignalingClientNotConnectErrorNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_callSignalingClientNotConnect;
  }
}

class CallSignalingClientSessionMissedErrorNotification extends Notification {
  const CallSignalingClientSessionMissedErrorNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_callSignalingClientSessionMissed;
  }
}

class CallConnectErrorNotification extends Notification {
  const CallConnectErrorNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_callConnect;
  }
}

class CallUserMediaErrorNotification extends Notification {
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
