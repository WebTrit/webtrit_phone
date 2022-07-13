import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../models/models.dart';

extension CodeInputErrorL10n on CodeInput {
  String? errorL10n(BuildContext context) {
    if (!invalid) {
      return null;
    } else {
      switch (error!) {
        case CodeValidationError.blank:
          return context.l10n.validationBlankError;
      }
    }
  }
}
