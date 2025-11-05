import 'package:flutter/widgets.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

extension RequestFailureExension on RequestFailure {
  List<ErrorFieldModel> errorFields(BuildContext context) {
    final message = error?.message;
    final detailsReason = error?.details?.reason;
    final detailsPath = error?.details?.path;

    return [
      ErrorFieldModel(context.l10n.request_StatusCode, statusCode.toString()),
      ErrorFieldModel(context.l10n.request_Id, requestId),
      if (message != null) ErrorFieldModel(context.l10n.default_ErrorMessage, message),
      if (detailsReason != null && message != detailsReason)
        ErrorFieldModel(context.l10n.default_ErrorDetails, detailsReason),
      if (detailsPath != null) ErrorFieldModel(context.l10n.default_ErrorPath, detailsPath),
    ];
  }
}
