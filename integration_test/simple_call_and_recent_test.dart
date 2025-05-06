import 'package:flutter/material.dart';
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
import 'subsequences/pump_for.dart';
import 'subsequences/pump_root_and_wait_until_visible.dart';

main() {
  final defaultLoginMethod = IntegrationTestEnvironmentConfig.DEFAULT_LOGIN_METHOD;
  const dialNumber = IntegrationTestEnvironmentConfig.SIMPLE_CALL_DESTINATION;

  patrolTest(
    'Should make simple call and check recents function',
    ($) async {
      await bootstrap();
      await pumpRootAndWaitUntilVisible($);

      // Login if not.
      if ($(LoginModeSelectScreen).visible) {
        await loginByMethod($, defaultLoginMethod);
        // Wait some time for components loading and session establishment.
        await pumpFor(const Duration(seconds: 5), $);
      }

      // Go to the dialer tab.
      await $(MainFlavor.keypad.toNavBarKey()).tap();

      // Enter the number to dial.
      for (var i = 0; i < dialNumber.length; i++) {
        final key = KeypadKey.numbers.firstWhere((element) => element.text == dialNumber[i]);
        await $(KeypadKeyButton).at(KeypadKey.numbers.indexOf(key)).tap();
      }

      // Start the call and talk for a while.
      await $(actionPadStartKey).tap();
      await $(CallActiveScaffold).waitUntilVisible();
      await pumpFor(const Duration(seconds: 5), $);
      expect(find.textContaining('00:0'), findsOneWidget, reason: 'Call should be active');

      // End the call.
      await $(callActionsHangupKey).tap();
      await pumpFor(const Duration(seconds: 2), $);
      expect($(CallActiveScaffold).visible, false, reason: 'Call should be ended');

      // Check if the call is in the recents list.
      await $(MainFlavor.recents.toNavBarKey()).tap();
      await $.pumpAndTrySettle();
      final recentNumbr = $(recentsTileKey).$(Row).$(dialNumber);
      expect(recentNumbr, findsOneWidget, reason: 'Should contain number in recents list');
      final recentIcon = $(recentsTileKey).$(Row).$(Icons.call_made);
      expect(recentIcon, findsOneWidget, reason: 'Should contain succesfull outgoing call icon');
    },
  );
}
