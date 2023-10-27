import 'package:flutter/widgets.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../models/models.dart';

extension SupportedLoginL10n on SupportedLogin {
  String l10n(BuildContext context) {
    switch (this) {
      case SupportedLogin.otpSignIn:
        return context.l10n.login_SegmentedButton_otpSignIn;
      case SupportedLogin.passwordSignIn:
        return context.l10n.login_SegmentedButton_passwordSignIn;
      default:
        return '';
    }
  }
}
