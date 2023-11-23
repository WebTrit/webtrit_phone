import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/localization.dart';

import '../models/models.dart';

extension PhoneValidationErrorL10n on PhoneValidationError {
  String? l10n(BuildContext context) {
    switch (this) {
      case PhoneValidationError.blank:
        return context.l10n.validationBlankError;
      case PhoneValidationError.format:
        return context.l10n.login_validationPhoneError;
    }
  }
}
