import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

extension ContactSourceTypeL10n on ContactSourceType {
  String l10n(BuildContext context) {
    switch (this) {
      case ContactSourceType.local:
        return context.l10n.contactsSourceLocal;
      case ContactSourceType.external:
        return context.l10n.contactsSourceExternal;
    }
  }
}
