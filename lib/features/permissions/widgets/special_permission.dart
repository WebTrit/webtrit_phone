import 'package:flutter/material.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../extensions/extensions.dart';

import 'permission_tips.dart';

class SpecialPermission extends StatelessWidget {
  const SpecialPermission({
    super.key,
    required this.specialPermissions,
    required this.onGoToAppSettings,
    required this.onPop,
  });

  final CallkeepSpecialPermissions specialPermissions;

  final VoidCallback onGoToAppSettings;
  final VoidCallback onPop;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Popping is routed through [onPop] instead of the navigator so that leaving
      // the screen with the system back gesture counts as the same deliberate
      // "later" as the button does.
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) return;
        onPop();
      },
      child: switch (specialPermissions) {
        CallkeepSpecialPermissions.fullScreenIntent => PermissionTips(
          title: context.l10n.permission_manageFullScreenNotificationPermissions,
          instruction: specialPermissions.tips(context),
          onGoToAppSettings: onGoToAppSettings,
          onPop: onPop,
          note: context.l10n.permission_fullScreenNotification_Text_optional,
          dismissLabel: context.l10n.permission_Button_notNow,
        ),
        // backgroundActivityStart is surfaced through ManufacturerPermission, not
        // this pipeline (it is not in AppPermissions._specialPermissions), so this
        // arm is currently unreachable and exists only to keep the switch exhaustive.
        CallkeepSpecialPermissions.backgroundActivityStart => PermissionTips(
          title: context.l10n.permission_manufacturer_Text_heading,
          instruction: specialPermissions.tips(context),
          onGoToAppSettings: onGoToAppSettings,
          onPop: onPop,
        ),
      },
    );
  }
}
