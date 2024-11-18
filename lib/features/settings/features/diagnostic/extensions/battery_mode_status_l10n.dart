import 'package:flutter/material.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

extension BatteryModeStatusL10n on CallkeepAndroidBatteryMode {
  String title(BuildContext context) {
    switch (this) {
      case CallkeepAndroidBatteryMode.unrestricted:
        return context.l10n.diagnostic_batteryMode_unrestricted_title;
      case CallkeepAndroidBatteryMode.optimized:
        return context.l10n.diagnostic_batteryMode_optimized_title;
      case CallkeepAndroidBatteryMode.restricted:
        return context.l10n.diagnostic_batteryMode_restricted_title;
      case CallkeepAndroidBatteryMode.unknown:
        return context.l10n.diagnostic_batteryMode_unknown_title;
    }
  }

  String description(BuildContext context) {
    switch (this) {
      case CallkeepAndroidBatteryMode.unrestricted:
        return context.l10n.diagnostic_batteryMode_unrestricted_description;
      case CallkeepAndroidBatteryMode.optimized:
        return context.l10n.diagnostic_batteryMode_optimized_description;
      case CallkeepAndroidBatteryMode.restricted:
        return context.l10n.diagnostic_batteryMode_restricted_description;
      case CallkeepAndroidBatteryMode.unknown:
        return context.l10n.diagnostic_batteryMode_unknown_description;
    }
  }

  // TODO(Serdun): Move to color scheme
  Color color(BuildContext context) {
    switch (this) {
      case CallkeepAndroidBatteryMode.restricted:
        return Colors.red;
      case CallkeepAndroidBatteryMode.unrestricted:
        return Colors.green;
      case CallkeepAndroidBatteryMode.unknown:
      case CallkeepAndroidBatteryMode.optimized:
        return Colors.orange;
    }
  }
}
