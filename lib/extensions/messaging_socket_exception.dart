import 'package:flutter/widgets.dart';

import 'package:webtrit_phone/features/messaging/messaging.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

extension MessagingSocketExceptionExt on MessagingSocketException {
  List<ErrorFieldModel> errorFields(BuildContext context) {
    return [
      ErrorFieldModel(context.l10n.request_StatusCode, code.toString()),
      ErrorFieldModel(context.l10n.default_ErrorPath, topic.toString()),
      ErrorFieldModel(context.l10n.default_ErrorMessage, message.toString()),
      ErrorFieldModel(context.l10n.default_ErrorDetails, details.toString()),
    ];
  }
}
