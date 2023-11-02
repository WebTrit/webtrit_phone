import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../models/models.dart';

extension EmailValidationErrorL10n on EmailValidationError {
  String? l10n(BuildContext context) {
    switch (this) {
      case EmailValidationError.blank:
        return context.l10n.validationBlankError;
      case EmailValidationError.format:
        return context.l10n.login_validationEmailError;
    }
  }
}
