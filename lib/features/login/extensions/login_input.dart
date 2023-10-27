import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../models/models.dart';

extension LoginValidationErrorL10n on LoginValidationError {
  String? l10n(BuildContext context) {
    switch (this) {
      case LoginValidationError.blank:
        return context.l10n.validationBlankError;
    }
  }
}
