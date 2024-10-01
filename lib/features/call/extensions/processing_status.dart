import 'package:flutter/widgets.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../models/models.dart';

extension ProcessingStatusL10n on ActiveCallStatus {
  String l10n(BuildContext context) {
    switch (this) {
      case ActiveCallStatus.disconnecting:
        return context.l10n.callProcessingStatus_disconnecting;
    }
  }
}
