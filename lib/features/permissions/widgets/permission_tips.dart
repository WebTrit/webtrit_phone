import 'package:flutter/material.dart';

import '../cubit/permissions_cubit.dart';

import 'miui_permission_tips.dart';

class PermissionTips extends StatelessWidget {
  const PermissionTips({
    super.key,
    required this.platform,
    required this.onGoToAppSettings,
  });

  final Manufacturer platform;
  final VoidCallback onGoToAppSettings;

  @override
  Widget build(BuildContext context) {
    switch (platform) {
      case Manufacturer.xiaomi:
        return MiuiPermissionTips(onGoToAppSettings: onGoToAppSettings);
    }
  }
}
