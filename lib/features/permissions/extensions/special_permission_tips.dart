import 'package:flutter/material.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

extension SpecialPermissionTips on CallkeepSpecialPermissions {
  List<String> tips(BuildContext context) {
    switch (this) {
      case CallkeepSpecialPermissions.fullScreenIntent:
        return [
          context.l10n.permission_manageFullScreenNotificationInstructions_step1,
          context.l10n.permission_manageFullScreenNotificationInstructions_step2,
          context.l10n.permission_manageFullScreenNotificationInstructions_step3,
          context.l10n.permission_manageFullScreenNotificationInstructions_step4,
          context.l10n.permission_manageFullScreenNotificationInstructions_step5,
        ];
      // Reached only if backgroundActivityStart is added to
      // AppPermissions._specialPermissions; today it is surfaced via the
      // manufacturer tip (ManufacturerTips.tips), which uses the same strings.
      case CallkeepSpecialPermissions.backgroundActivityStart:
        return [
          context.l10n.permission_manufacturer_Text_xiaomi_tip1,
          context.l10n.permission_manufacturer_Text_xiaomi_tip2,
        ];
    }
  }
}
