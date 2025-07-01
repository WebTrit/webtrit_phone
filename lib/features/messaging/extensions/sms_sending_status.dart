import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/messaging/sms_conversation/sms_message.dart';

extension SmsSendingStatusL10n on SmsSendingStatus {
  String nameL10n(BuildContext context) {
    switch (this) {
      case SmsSendingStatus.waiting:
        return context.l10n.messaging_SmsSendingStatus_waiting;
      case SmsSendingStatus.sent:
        return context.l10n.messaging_SmsSendingStatus_sent;
      case SmsSendingStatus.failed:
        return context.l10n.messaging_SmsSendingStatus_failed;
      case SmsSendingStatus.delivered:
        return context.l10n.messaging_SmsSendingStatus_delivered;
    }
  }
}
