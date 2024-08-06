import 'package:flutter/material.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

extension AccountErrorCodeL10n on AccountErrorCode {
  String l10n(BuildContext context) {
    return switch (this) {
      AccountErrorCode.passwordChangeRequired => context.l10n.account_selfCarePasswordExpired_message,
    };
  }
}
