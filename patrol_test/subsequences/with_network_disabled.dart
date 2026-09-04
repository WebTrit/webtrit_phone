import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

/// Turns the device's network off for the duration of [body] and guarantees
/// it comes back on - even when [body] fails - so one red assertion cannot
/// leave the device offline for every later test in the bundle.
///
/// Wifi and cellular toggles run through the shell (`svc`), unlike the
/// airplane-mode helper which drives the quick-settings UI and does not find
/// its tile on every device.
Future<void> withNetworkDisabled(PatrolIntegrationTester $, Future<void> Function() body) async {
  var restored = false;
  Future<void> restore() async {
    if (restored) return;
    restored = true;
    await $.platformAutomator.mobile.enableWifi();
    await $.platformAutomator.mobile.enableCellular();
  }

  addTearDown(restore);

  await $.platformAutomator.mobile.disableWifi();
  await $.platformAutomator.mobile.disableCellular();
  try {
    await body();
  } finally {
    await restore();
  }
}
