import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

@immutable
abstract class Notification {
  const Notification();

  String l10n(BuildContext context);
}

class CallSignalingClientNotReadyErrorNotification extends Notification {
  const CallSignalingClientNotReadyErrorNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.notifications_errorSnackBar_callSignalingClientNotReady;
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
}
