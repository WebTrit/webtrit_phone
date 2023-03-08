import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../models/models.dart';

extension UrlValidationErrorL10n on UrlValidationError {
  String? l10n(BuildContext context) {
    switch (this) {
      case UrlValidationError.blank:
        return context.l10n.validationBlankError;
      case UrlValidationError.format:
        return context.l10n.login_validationCoreUrlError;
    }
  }
}
