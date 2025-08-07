import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/call/view/call_active_scaffold.dart';
import 'package:webtrit_phone/features/login/view/login_mode_select_screen.dart';
import 'package:webtrit_phone/models/main_flavor.dart';

import 'components/integration_test_environment_config.dart';
import 'subsequences/enter_keypad_number.dart';
import 'subsequences/login_by_method.dart';
import 'subsequences/pump_for.dart';
import 'subsequences/pump_root_and_wait_until_visible.dart';

main() {
  final defaultLoginMethod = IntegrationTestEnvironmentConfig.DEFAULT_LOGIN_METHOD;
  const callNumberA = IntegrationTestEnvironmentConfig.CALL_NUMBER_A;
  const callNumberB = IntegrationTestEnvironmentConfig.CALL_NUMBER_B;
  const crossCallSleep = Duration(seconds: IntegrationTestEnvironmentConfig.CROSS_CALL_SLEEP_SECONDS);

  patrolTest(
    'Should make blind and attended transfers',
    ($) async {
      await bootstrap();
      await pumpRootAndWaitUntilVisible($);

      // Login if not.
      if ($(LoginModeSelectScreen).visible) {
        await loginByMethod($, defaultLoginMethod);
        // Wait some time for components loading and session establishment.
        await pumpFor(const Duration(seconds: 5), $);
      }

      // Make a call and wait for it to be active.
      await $(MainFlavor.keypad.toNavBarKey()).tap();
      await enterKeypadNumber($, callNumberA);
      await $(actionPadStartKey).tap();
      await $(CallActiveScaffold).waitUntilVisible();
      await pumpFor(const Duration(seconds: 5), $);
      expect(find.textContaining('00:0'), findsOneWidget, reason: 'Call1 should be active');

      // Transfer the call blindly and verify that the call is transferred.
      await $(callActionsTransferMenuKey).tap();
      await $(callActionsTransferMenuBlindInitKey).tap();
      await $(MainFlavor.keypad.toNavBarKey()).tap();
      await enterKeypadNumber($, callNumberB);
      await $(actionPadStartKey).tap();
      await pumpFor(const Duration(seconds: 2), $);
      expect($(CallActiveScaffold).visible, false, reason: 'Call1 should be transferred');

      await Future.delayed(crossCallSleep);

      // Make a call and wait for it to be active.
      await $(MainFlavor.keypad.toNavBarKey()).tap();
      await enterKeypadNumber($, callNumberA);
      await $(actionPadStartKey).tap();
      await $(CallActiveScaffold).waitUntilVisible();
      await pumpFor(const Duration(seconds: 5), $);
      expect(find.textContaining('00:0'), findsOneWidget, reason: 'Call2 should be active');

      // Make second call and wait for it to be active.
      await $.native.pressBack();
      await $(MainFlavor.keypad.toNavBarKey()).tap();
      await enterKeypadNumber($, callNumberB);
      await $(actionPadStartKey).tap();
      await $(CallActiveScaffold).waitUntilVisible();
      await pumpFor(const Duration(seconds: 5), $);
      expect(find.textContaining('On Hold'), findsOneWidget, reason: 'One call should be on hold');
      expect(find.textContaining('00:0'), findsOneWidget, reason: 'Another call should be active');

      // Make attended transfer and verify that the call is transferred.
      await $(callActionsTransferMenuKey).tap();
      await $(callActionsTransferMenuNumberKey).at(0).tap();
      await pumpFor(const Duration(seconds: 2), $);
      expect($(CallActiveScaffold).visible, false, reason: 'Call2 should be transferred');

      await Future.delayed(crossCallSleep);
    },
  );
}
