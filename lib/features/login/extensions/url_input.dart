import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../models/models.dart';

extension UrlInputErrorL10n on UrlInput {
  String? errorL10n(BuildContext context) {
    if (!invalid) {
      return null;
    } else {
      switch (error!) {
        case UrlValidationError.blank:
          return context.l10n.validationBlankError;
        case UrlValidationError.format:
          return context.l10n.login_validationCoreUrlError;
      }
    }
  }
}
