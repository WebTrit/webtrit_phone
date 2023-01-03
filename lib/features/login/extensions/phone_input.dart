import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../models/models.dart';

extension PhoneInputErrorL10n on PhoneInput {
  String? errorL10n(BuildContext context) {
    if (!invalid) {
      return null;
    } else {
      switch (error!) {
        case PhoneValidationError.blank:
          return context.l10n.validationBlankError;
        case PhoneValidationError.format:
          return context.l10n.login_validationPhoneError;
      }
    }
  }
}
