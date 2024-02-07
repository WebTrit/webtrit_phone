import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../models/code_input.dart';

extension CodeValidationErrorL10n on CodeValidationError {
  String? l10n(BuildContext context) {
    switch (this) {
      case CodeValidationError.blank:
        return context.l10n.validationBlankError;
    }
  }
}
