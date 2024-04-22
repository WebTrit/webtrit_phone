import 'package:flutter/widgets.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../models/undefined_type.dart';

extension UndefinedTypeExtensionsL10n on UndefinedType {
  String l10n(BuildContext context) {
    switch (this) {
      case UndefinedType.deeplinkConfigurationInvalid:
        return context.l10n.autoprovision_errorSnackBar_invalidToken;
    }
  }
}
