import 'package:flutter/material.dart';

import 'package:webtrit_phone/notifications/models/models.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

final class InvalidAutoProvisioningToken extends ErrorNotification {
  const InvalidAutoProvisioningToken();

  @override
  String l10n(BuildContext context) {
    return context.l10n.autoprovision_errorSnackBar_invalidToken;
  }
}

final class SuccesfulUsedAutoProvisioningToken extends SuccessNotification {
  const SuccesfulUsedAutoProvisioningToken();

  @override
  String l10n(BuildContext context) {
    return context.l10n.autoprovision_successSnackBar_used;
  }
}
