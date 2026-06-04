import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:pjsua_companion/pjsua_companion.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/models/main_flavor.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/call/view/call_active_scaffold.dart';
import 'package:webtrit_phone/features/login/view/login_mode_select_screen.dart';

import 'components/integration_test_environment_config.dart';
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

  patrolTest('Should open keypad, enter number and make call', ($) async {
    final instanceRegistry = await bootstrap();
    await pumpRootAndWaitUntilVisible(instanceRegistry, $);

    // Login if not.
    if ($(LoginModeSelectScreen).visible) {
      await loginByMethod($, defaultLoginMethod);
      // Wait some time for components loading and session establishment.
      await pumpFor(const Duration(seconds: 5), $);
    }

    final pjsuaCallServerClient = PjsuaCompanionClient(host: pjsuaServerHost, port: pjsuaServerPort);
    final companionPid = await pjsuaCallServerClient.registerAutoanswer(
      sipServer: remoteSipServer,
      sipUsername: remoteUser,
      sipPassword: remotePassword,
    );

    // Make a call and check if it is active.
    await $(MainFlavor.keypad.toNavBarKey()).tap();
    await enterKeypadNumber($, callNumber);
    await $(Icons.call).tap();
    await $(CallActiveScaffold).waitUntilVisible();
    await pumpFor(const Duration(seconds: 5), $);
    expect(find.textContaining('00:0'), findsOneWidget, reason: 'Call should be active');

    // Hangup call and check if it is done.
    await $(callActionsHangupKey).tap();
    await pumpFor(const Duration(seconds: 2), $);
    expect($(CallActiveScaffold).visible, false, reason: 'Call should be ended');

    // Teardowning
    pjsuaCallServerClient.close(companionPid).ignore();
    await logout($);
  }, skip: hasCredsToRunThisTest == false);
}
