import 'package:flutter/widgets.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/features/call/extensions/extensions.dart';
import 'package:webtrit_phone/app/notifications/notifications.dart';

extension SignalingHangupFailureExt on SignalingHangupFailure {
  List<ErrorFieldModel> errorFields(BuildContext context) {
    return [
      ErrorFieldModel(context.l10n.default_ErrorMessage, code.type.l10n(context)),
      ErrorFieldModel(context.l10n.default_ErrorDetails, code.l10n(context)),
      ErrorFieldModel(context.l10n.request_StatusCode, code.code.toString()),
    ];
  }
}
