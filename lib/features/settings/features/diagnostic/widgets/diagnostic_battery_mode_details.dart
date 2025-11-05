import 'package:flutter/material.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../extensions/extensions.dart';

class DiagnosticBatteryModeDetails extends StatelessWidget {
  const DiagnosticBatteryModeDetails({super.key, required this.batteryMode, this.onTap});

  final CallkeepAndroidBatteryMode batteryMode;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final permissionTitle = batteryMode.title(context);
    final permissionDescription = batteryMode.description(context);
    final statusColor = batteryMode.color(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(title: Text(context.l10n.diagnostic_battery_tile_title), subtitle: Text(permissionDescription)),
          ListTile(
            title: Text(context.l10n.diagnosticPermissionDetails_title_statusPermission),
            subtitle: Text(permissionTitle, style: textTheme.bodyMedium?.copyWith(color: statusColor)),
          ),
          ListTile(
            title: Text(
              context.l10n.diagnosticPermissionDetails_button_managePermission,
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.primary),
            ),
            subtitle: Text(context.l10n.diagnostic_battery_navigate_section, style: textTheme.bodySmall),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
