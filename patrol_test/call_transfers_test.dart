import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:pjsua_companion/pjsua_companion.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/login/view/login_mode_select_screen.dart';
import 'package:webtrit_phone/models/main_flavor.dart';
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

  final remoteSipServer = IntegrationTestEnvironmentConfig.PJSUA_SIP_SERVER;
  final pjsuaServerHost = IntegrationTestEnvironmentConfig.PJSUA_SERVER_HOST;
  final pjsuaServerPort = IntegrationTestEnvironmentConfig.PJSUA_SERVER_PORT;

  final contactANumber = IntegrationTestEnvironmentConfig.EXT_CONTACT_A_UNIQUE_NUMBER;
  final contactASipUsername = IntegrationTestEnvironmentConfig.EXT_CONTACT_A_SIP_USERNAME;
  final contactASipPassword = IntegrationTestEnvironmentConfig.EXT_CONTACT_A_SIP_PASSWORD;

  final contactBNumber = IntegrationTestEnvironmentConfig.EXT_CONTACT_B_UNIQUE_NUMBER;
  final contactBSipUsername = IntegrationTestEnvironmentConfig.EXT_CONTACT_B_SIP_USERNAME;
  final contactBSipPassword = IntegrationTestEnvironmentConfig.EXT_CONTACT_B_SIP_PASSWORD;

  const crossCallSleep = Duration(seconds: IntegrationTestEnvironmentConfig.CROSS_CALL_SLEEP_SECONDS);

  final hasCredsToRunThisTest =
      pjsuaServerHost.isNotEmpty &&
      pjsuaServerPort != 0 &&
      contactASipUsername.isNotEmpty &&
      contactASipPassword.isNotEmpty &&
      remoteSipServer.isNotEmpty;

  patrolTest('Verifies blind and attended transfers functionality', ($) async {
    final pjsuaCallServerClient = PjsuaCompanionClient(host: pjsuaServerHost, port: pjsuaServerPort);

    final instanceRegistry = await bootstrap();
    await pumpRootAndWaitUntilVisible(instanceRegistry, $);

    // Disable shimmer animation to unblock settle waiters when call is minimized.
    // ignore: invalid_use_of_visible_for_testing_member
    testSemanticsDisableShimmerAnimation = true;

    // Login if not.
    if ($(LoginModeSelectScreen).visible) {
      await loginByMethod($, defaultLoginMethod);
      // Wait some time for components loading and session establishment.
      await pumpFor(const Duration(seconds: 5), $);
    }

    // Prepare companions for outgoing call.
    var contactACompanionPid = await pjsuaCallServerClient.registerAutoanswer(
      sipServer: remoteSipServer,
      sipUsername: contactASipUsername,
      sipPassword: contactASipPassword,
    );
    var contactBCompanionPid = await pjsuaCallServerClient.registerAutoanswer(
      sipServer: remoteSipServer,
      sipUsername: contactBSipUsername,
      sipPassword: contactBSipPassword,
    );

    // Make a call and wait for it to be active.
    await $(MainFlavor.keypad.toNavBarKey()).tap();
    await enterKeypadNumber($, contactANumber);
    await $(Icons.call).tap();
    await expectActiveCall($);
    await expectActiveCallDurationGte(const Duration(seconds: 5), $);

    // Transfer the call blindly and verify that the call is transferred.
    await $(callActionsTransferMenuKey).tap();
    await $(callActionsTransferMenuBlindInitKey).tap();
    await $(MainFlavor.keypad.toNavBarKey()).tap();
    await enterKeypadNumber($, contactBNumber);
    await $(Icons.phone_forwarded).tap();
    await expectActiveCallHangup($);

    // Release companion processes.
    pjsuaCallServerClient.close(contactACompanionPid).ignore();
    pjsuaCallServerClient.close(contactBCompanionPid).ignore();

    await Future.delayed(crossCallSleep);

    // Prepare new companions for second test scenario.
    contactACompanionPid = await pjsuaCallServerClient.registerAutoanswer(
      sipServer: remoteSipServer,
      sipUsername: contactASipUsername,
      sipPassword: contactASipPassword,
    );
    contactBCompanionPid = await pjsuaCallServerClient.registerAutoanswer(
      sipServer: remoteSipServer,
      sipUsername: contactBSipUsername,
      sipPassword: contactBSipPassword,
    );

    // Make a call and wait for it to be active.
    await $(MainFlavor.keypad.toNavBarKey()).tap();
    await enterKeypadNumber($, contactANumber);
    await $(Icons.call).tap();
    await expectActiveCall($);
    await expectActiveCallDurationGte(const Duration(seconds: 5), $);
    // Make second call and wait for it to be active.
    // await $.platformAutomator.mobile.swipeBack();
    await $(callActionsTransferMenuKey).tap();
    await $(callActionsTransferMenuAttendedInitKey).tap();
    await $(MainFlavor.keypad.toNavBarKey()).tap();
    await enterKeypadNumber($, contactBNumber);
    await $(Icons.call).tap();
    await expectActiveCall($);
    await expectActiveCallDurationGte(const Duration(seconds: 5), $);
    expect(find.textContaining('On hold'), findsOneWidget, reason: 'One call should be on hold');

    // Make attended transfer and verify that the call is transferred.
    await $(callActionsTransferMenuKey).tap();
    await $(callActionsTransferMenuNumberKey).at(0).tap();
    await expectActiveCallHangup($);

    // Close companions.
    pjsuaCallServerClient.close(contactACompanionPid).ignore();
    pjsuaCallServerClient.close(contactBCompanionPid).ignore();

    // Teardowning
    await logout($);
  }, skip: hasCredsToRunThisTest == false);
}
