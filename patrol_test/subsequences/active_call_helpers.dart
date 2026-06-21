
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/extensions/duration.dart';
import 'package:webtrit_phone/features/call/view/call_active_scaffold.dart';

Future<void> expectActiveCall(PatrolIntegrationTester $) async {
  await $(CallActiveScaffold).waitUntilVisible();
  expect($(CallActiveScaffold), findsOneWidget, reason: 'Call screen should be shown');
}

Future expectActiveCallDurationGte(Duration duration, PatrolIntegrationTester $) async {
  // Match 3+ seconds for better reliability on laggy devices.
  final time = duration.format();
  final timePlusOne = (duration + const Duration(seconds: 1)).format();
  final timePlusTwo = (duration + const Duration(seconds: 2)).format();

  await $(RegExp('$time|$timePlusOne|$timePlusTwo')).waitUntilVisible(timeout: const Duration(seconds: 10));
  expect(find.textContaining(time), findsOneWidget, reason: 'Call should be active for at least $time seconds');
}

Future<void> expectActiveCallHangup(PatrolIntegrationTester $) async {
  final pumpFor = Duration(seconds: 5);
  for (var i = 0; i < pumpFor.inMilliseconds ~/ 100; i++) {
    await Future.delayed(const Duration(milliseconds: 100));
    await $.pump();
    if ($(CallActiveScaffold).visible == false) break;
  }
  expect($(CallActiveScaffold).visible, false, reason: 'Call should be ended');
}