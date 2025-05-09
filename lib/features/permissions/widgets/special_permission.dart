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
    switch (specialPermissions) {
      case CallkeepSpecialPermissions.fullScreenIntent:
        return PermissionTips(
          title: context.l10n.permission_manageFullScreenNotificationPermissions,
          instruction: specialPermissions.tips(context),
          onGoToAppSettings: onGoToAppSettings,
          onPop: onPop,
        );
    }
  }
}
