import 'package:flutter/widgets.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../models/undefined_type.dart';

extension UndefinedTypeExtensionsL10n on UndefinedType {
  String titleL10n(BuildContext context) {
    final l10n = context.l10n;
    switch (this) {
      case UndefinedType.deeplinkConfigurationInvalid:
        return l10n.undefined_autoprovision_invalidToken_title;
      case UndefinedType.stackScreenNotSupported:
        return l10n.undefined_stackScreenNotSupported_title;
    }
  }

  String descriptionL10n(BuildContext context) {
    final l10n = context.l10n;
    switch (this) {
      case UndefinedType.deeplinkConfigurationInvalid:
        return l10n.undefined_autoprovision_invalidToken;
      case UndefinedType.stackScreenNotSupported:
        return l10n.undefined_stackScreenNotSupported;
    }
  }
}
