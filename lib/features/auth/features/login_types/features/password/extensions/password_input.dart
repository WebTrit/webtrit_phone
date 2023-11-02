import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../models/models.dart';

extension PasswordValidationErrorL10n on PasswordValidationError {
  String? l10n(BuildContext context) {
    switch (this) {
      case PasswordValidationError.blank:
        return context.l10n.validationBlankError;
    }
  }
}
