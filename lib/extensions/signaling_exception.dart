import 'package:flutter/widgets.dart';

import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

extension SignalingExceptionExension on WebtritSignalingException {
  List<ErrorFieldModel> errorFields(BuildContext context) {
    final e = this; // Just for cast

    final requestId = e.id.toString();
    final message = e.toString();

    return [
      ErrorFieldModel(context.l10n.request_Id, requestId),
      ErrorFieldModel(context.l10n.default_ErrorMessage, message.toString()),
      if (e is WebtritSignalingErrorException) ...[
        ErrorFieldModel(context.l10n.request_StatusCode, e.code.toString()),
        ErrorFieldModel(context.l10n.default_ErrorDetails, e.reason),
      ],
      if (e is WebtritSignalingTransactionException) ...[
        ErrorFieldModel(context.l10n.default_ErrorTransactionId, e.transactionId),
      ]
    ];
  }
}
