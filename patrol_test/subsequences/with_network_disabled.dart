import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

/// Turns the device's network off for the duration of [body] and guarantees
/// it comes back on - even when [body] fails - so one red assertion cannot
/// leave the device offline for every later test in the bundle.
///
/// Wifi and cellular toggles run through the shell (`svc`), unlike the
/// airplane-mode helper which drives the quick-settings UI and does not find
/// its tile on every device.
Future<T> withNetworkDisabled<T>(PatrolIntegrationTester $, Future<T> Function() body) async {
  final network = _RestorableNetwork($);
  addTearDown(network.restore);

  await network.disable();
  try {
    return await body();
  } finally {
    await network.restore();
  }
}

class _RestorableNetwork {
  _RestorableNetwork(this.$);

  final PatrolIntegrationTester $;
  var _restored = false;

  Future<void> disable() async {
    await $.platformAutomator.mobile.disableWifi();
    await $.platformAutomator.mobile.disableCellular();
  }

  Future<void> restore() async {
    if (_restored) return;
    await $.platformAutomator.mobile.enableWifi();
    await $.platformAutomator.mobile.enableCellular();
    _restored = true;
  }
}
