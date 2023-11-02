import 'package:flutter/widgets.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

extension SupportedLoginL10n on SupportedLoginType {
  String l10n(BuildContext context) {
    switch (this) {
      case SupportedLoginType.otpSignIn:
        return context.l10n.login_SegmentedButton_otpSignIn;
      case SupportedLoginType.passwordSignIn:
        return context.l10n.login_SegmentedButton_passwordSignIn;
      default:
        return '';
    }
  }
}
