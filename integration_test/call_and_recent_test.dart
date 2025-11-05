import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/models/main_flavor.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/call/view/call_active_scaffold.dart';
import 'package:webtrit_phone/features/login/view/login_mode_select_screen.dart';

import 'components/integration_test_environment_config.dart';
import 'subsequences/enter_keypad_number.dart';
import 'subsequences/login_by_method.dart';
import 'subsequences/pump_for.dart';
import 'subsequences/pump_root_and_wait_until_visible.dart';

main() {
  final defaultLoginMethod = IntegrationTestEnvironmentConfig.DEFAULT_LOGIN_METHOD;
  const callNumber = IntegrationTestEnvironmentConfig.CALL_NUMBER_A;
  const crossCallSleep = Duration(seconds: IntegrationTestEnvironmentConfig.CROSS_CALL_SLEEP_SECONDS);

  patrolTest('Should make simple call and verify recents', ($) async {
    await bootstrap();
    await pumpRootAndWaitUntilVisible($);

    // Login if not.
    if ($(LoginModeSelectScreen).visible) {
      await loginByMethod($, defaultLoginMethod);
      // Wait some time for components loading and session establishment.
      await pumpFor(const Duration(seconds: 5), $);
    }

    // Make a call and check if it is active.
    await $(MainFlavor.keypad.toNavBarKey()).tap();
    await enterKeypadNumber($, callNumber);
    await $(actionPadStartKey).tap();
    await $(CallActiveScaffold).waitUntilVisible();
    await pumpFor(const Duration(seconds: 5), $);
    expect(find.textContaining('00:0'), findsOneWidget, reason: 'Call should be active');

    // Hangup call and check if it is done.
    await $(callActionsHangupKey).tap();
    await pumpFor(const Duration(seconds: 2), $);
    expect($(CallActiveScaffold).visible, false, reason: 'Call should be ended');

    // Check if the call is in the recents list.
    await $(MainFlavor.recents.toNavBarKey()).tap();
    await $.pumpAndTrySettle();
    final recentNumbr = $(recentsTileKey).$(Row).$(callNumber);
    expect(recentNumbr, findsOneWidget, reason: 'Should contain number in recents list');
    final recentIcon = $(recentsTileKey).$(Row).$(Icons.call_made);
    expect(recentIcon, findsOneWidget, reason: 'Should contain succesfull outgoing call icon');

    await Future.delayed(crossCallSleep);
  });
}
