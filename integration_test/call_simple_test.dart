import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/call/view/call_active_scaffold.dart';
import 'package:webtrit_phone/features/login/view/login_mode_select_screen.dart';
import 'package:webtrit_phone/models/keypad_key.dart';
import 'package:webtrit_phone/models/main_flavor.dart';
import 'package:webtrit_phone/widgets/keypad_key_button.dart';

import 'components/integration_test_environment_config.dart';
import 'subsequences/login_by_method.dart';
import 'subsequences/pump_root_and_wait_until_visible.dart';

main() {
  final defaultLoginMethod = IntegrationTestEnvironmentConfig.DEFAULT_LOGIN_METHOD;

  patrolTest(
    'Should make simple call and hangup it',
    ($) async {
      await bootstrap();
      await pumpRootAndWaitUntilVisible($);

      // Login if not.
      if ($(LoginModeSelectScreen).visible) {
        await loginByMethod($, defaultLoginMethod);
        // Wait some time for components loading and session establishment.
        await Future.delayed(const Duration(seconds: 5), () => $.pumpAndTrySettle());
      }

      // Go to the dialer tab.
      await $(MainFlavor.keypad.toNavBarKey()).tap();

      // Enter the number to dial.
      const dialNumber = IntegrationTestEnvironmentConfig.SIMPLE_CALL_DESTINATION;
      for (var i = 0; i < dialNumber.length; i++) {
        final key = KeypadKey.numbers.firstWhere((element) => element.text == dialNumber[i]);
        await $(KeypadKeyButton).at(KeypadKey.numbers.indexOf(key)).tap();
      }

      // Start the call.
      await $(actionPadStartKey).tap();
      await $(CallActiveScaffold).waitUntilVisible();

      // Let them talk for a while.
      await Future.delayed(const Duration(seconds: 5));
      await $.pumpAndTrySettle();

      // Check if the call is active based on counter presence.
      expect(find.textContaining('00:0'), findsOneWidget);

      // End the call.
      await $(callActionsHangupKey).tap();
      await Future.delayed(const Duration(seconds: 2));
      await $.pumpAndTrySettle();

      expect($(CallActiveScaffold).visible, false);
    },
  );
}
