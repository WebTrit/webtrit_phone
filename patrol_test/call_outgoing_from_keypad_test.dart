import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:patrol/patrol.dart';
import 'package:pjsua_companion/pjsua_companion.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/models/main_flavor.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/login/view/login_mode_select_screen.dart';
import 'package:webtrit_phone/widgets/shimmer.dart';

import 'components/integration_test_environment_config.dart';
import 'subsequences/active_call_helpers.dart';
import 'subsequences/enter_keypad_number.dart';
import 'subsequences/login_by_method.dart';
import 'subsequences/logout.dart';
import 'subsequences/pump_for.dart';
import 'subsequences/pump_root_and_wait_until_visible.dart';

void main() {
  final defaultLoginMethod = IntegrationTestEnvironmentConfig.DEFAULT_LOGIN_METHOD;
  const callNumber = IntegrationTestEnvironmentConfig.EXT_CONTACT_A_UNIQUE_NUMBER;

  final pjsuaServerHost = IntegrationTestEnvironmentConfig.PJSUA_SERVER_HOST;
  final pjsuaServerPort = IntegrationTestEnvironmentConfig.PJSUA_SERVER_PORT;
  final remoteSipServer = IntegrationTestEnvironmentConfig.PJSUA_SIP_SERVER;

  final remoteUser = IntegrationTestEnvironmentConfig.EXT_CONTACT_A_SIP_USERNAME;
  final remotePassword = IntegrationTestEnvironmentConfig.EXT_CONTACT_A_SIP_PASSWORD;

  final hasCredsToRunThisTest =
      remoteUser.isNotEmpty &&
      remotePassword.isNotEmpty &&
      remoteSipServer.isNotEmpty &&
      pjsuaServerHost.isNotEmpty &&
      pjsuaServerPort != 0;

  patrolTest('Verifies keypad call functionality', ($) async {
    final instanceRegistry = await bootstrap();
    await pumpRootAndWaitUntilVisible(instanceRegistry, $);

    // Disable shimmer animation to unblock settle waiters when call is minimized.
    // ignore: invalid_use_of_visible_for_testing_member
    testSemanticsDisableShimmerAnimation = true;
    debugSemanticsDisableAnimations = true;

    // Login if not.
    if ($(LoginModeSelectScreen).visible) {
      await loginByMethod($, defaultLoginMethod);
      // Wait some time for components loading and session establishment.
      await pumpFor(const Duration(seconds: 5), $);
    }

    // Open keypad and enter number.
    await $(MainFlavor.keypad.toNavBarKey()).tap();
    await enterKeypadNumber($, callNumber);

    // Prepare remote client for incoming call.
    final pjsuaCallServerClient = PjsuaCompanionClient(host: pjsuaServerHost, port: pjsuaServerPort);
    final companionPid = await pjsuaCallServerClient.registerAutoanswer(
      sipServer: remoteSipServer,
      sipUsername: remoteUser,
      sipPassword: remotePassword,
    );

    // Make a call and check if it is active.
    await $(Icons.call).tap();
    await expectActiveCall($);
    await expectActiveCallDurationGte(const Duration(seconds: 3), $);

    // Hangup call and check if it is done.
    await $(callActionsHangupKey).tap();
    await expectActiveCallHangup($);

    // Teardowning
    pjsuaCallServerClient.close(companionPid).ignore();
    await logout($);
  }, skip: hasCredsToRunThisTest == false);
}

