import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../models/models.dart';

extension UserRefValidationErrorL10n on UserRefValidationError {
  String? l10n(BuildContext context) {
    switch (this) {
      case UserRefValidationError.blank:
        return context.l10n.validationBlankError;
      case UserRefValidationError.format:
        return context.l10n.login_validationUserRefError;
    }
  }
}
