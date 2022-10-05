import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../models/models.dart';

extension EmailInputErrorL10n on EmailInput {
  String? errorL10n(BuildContext context) {
    if (!invalid) {
      return null;
    } else {
      switch (error!) {
        case EmailValidationError.blank:
          return context.l10n.validationBlankError;
        case EmailValidationError.format:
          return context.l10n.login_validationEmailError;
      }
    }
  }
}
