import 'package:flutter/material.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

import '../extensions/extensions.dart';

class DiagnosticBatteryModeItem extends StatelessWidget {
  const DiagnosticBatteryModeItem({
    super.key,
    required this.onTap,
    required this.batteryMode,
  });

  final Function() onTap;
  final CallkeepAndroidBatteryMode batteryMode;

  @override
  Widget build(BuildContext context) {
    final statusText = batteryMode.title(context);
    final statusColor = batteryMode.color(context);

    final statusIcon =
        batteryMode == CallkeepAndroidBatteryMode.unrestricted ? Icons.check_circle : Icons.error_outline;

    return ListTile(
      onTap: onTap.call,
      title: Text(context.l10n.diagnostic_battery_tile_title),
      subtitle: Text(statusText),
      trailing: Icon(
        statusIcon,
        color: statusColor,
      ),
    );
  }
}
