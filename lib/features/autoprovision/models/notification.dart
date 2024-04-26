import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/notifications/models/models.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

class InvalidAutoProvisioningToken extends ErrorNotification {
  const InvalidAutoProvisioningToken();

  @override
  String l10n(BuildContext context) {
    return context.l10n.autoprovision_errorSnackBar_invalidToken;
  }
}

class SuccesfulUsedAutoProvisioningToken extends SuccessNotification {
  const SuccesfulUsedAutoProvisioningToken();

  @override
  String l10n(BuildContext context) {
    return context.l10n.autoprovision_successSnackBar_used;
  }
}
