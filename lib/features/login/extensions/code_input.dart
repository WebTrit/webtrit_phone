import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/localization.dart';

import '../models/models.dart';

extension CodeValidationErrorL10n on CodeValidationError {
  String? l10n(BuildContext context) {
    switch (this) {
      case CodeValidationError.blank:
        return context.l10n.validationBlankError;
    }
  }
}
