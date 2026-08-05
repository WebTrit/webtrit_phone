import 'package:flutter/material.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

extension SpecialPermissionStatusL10n on CallkeepSpecialPermissionStatus {
  String title(BuildContext context) {
    switch (this) {
      case CallkeepSpecialPermissionStatus.granted:
        return context.l10n.diagnostic_specialPermissionStatus_granted;
      case CallkeepSpecialPermissionStatus.denied:
        return context.l10n.diagnostic_specialPermissionStatus_denied;
      case CallkeepSpecialPermissionStatus.unknown:
        return context.l10n.diagnostic_specialPermissionStatus_unknown;
    }
  }

  // TODO(Serdun): Move to color scheme
  Color color(BuildContext context) {
    switch (this) {
      case CallkeepSpecialPermissionStatus.granted:
        return Colors.green;
      case CallkeepSpecialPermissionStatus.denied:
        return Colors.red;
      case CallkeepSpecialPermissionStatus.unknown:
        return Colors.orange;
    }
  }
}
