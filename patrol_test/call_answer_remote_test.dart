import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/features/call/view/call_active_scaffold.dart';
import 'package:webtrit_phone/features/login/view/login_mode_select_screen.dart';

import 'components/integration_test_environment_config.dart';
import 'subsequences/login_by_method.dart';
import 'subsequences/pump_for.dart';
import 'subsequences/pump_root_and_wait_until_visible.dart';
import 'package:pjsua_companion/pjsua_companion.dart';

void main() {
  final defaultLoginMethod = IntegrationTestEnvironmentConfig.DEFAULT_LOGIN_METHOD;
  const calleeNumber = IntegrationTestEnvironmentConfig.ACCOUNT_MAIN_NUMBER;
  const crossCallSleep = Duration(seconds: IntegrationTestEnvironmentConfig.CROSS_CALL_SLEEP_SECONDS);

  final remoteUser = IntegrationTestEnvironmentConfig.PJSUA_SIP_USERNAME;
  final remoteSipServer = IntegrationTestEnvironmentConfig.PJSUA_SIP_SERVER;
  final remotePassword = IntegrationTestEnvironmentConfig.PJSUA_SIP_PASSWORD;
  final pjsuaServerHost = IntegrationTestEnvironmentConfig.PJSUA_SERVER_HOST;
  final pjsuaServerPort = IntegrationTestEnvironmentConfig.PJSUA_SERVER_PORT;

  final hasCredsToRunThisTest =
      remoteUser.isNotEmpty &&
      remoteSipServer.isNotEmpty &&
      remotePassword.isNotEmpty &&
      pjsuaServerHost.isNotEmpty &&
      pjsuaServerPort != 0;

  patrolTest(
    'Should answer incoming call using app UI > verify it is active > verify remote hangup',
    ($) async {
      /// Prepare
      final pjsuaCallServerClient = PjsuaCompanionClient(host: pjsuaServerHost, port: pjsuaServerPort);

      Future<int> placeIncomingCall($) async {
        final pid = await pjsuaCallServerClient.call(
          calleeNumber,
          sipServer: remoteSipServer,
          sipUsername: remoteUser,
          sipPassword: remotePassword,
        );
        return pid;
      }

      final instanceRegistry = await bootstrap();
      await pumpRootAndWaitUntilVisible(instanceRegistry, $);

      //// Test

      // Login if not.
      if ($(LoginModeSelectScreen).visible) {
        await loginByMethod($, defaultLoginMethod);
        // Wait some time for components loading and session establishment.
        await pumpFor(const Duration(seconds: 5), $);
      }

      // Place incoming call and wait for it
      final pid = await placeIncomingCall($);
      await $(CallActiveScaffold).waitUntilVisible(timeout: const Duration(seconds: 10));

      // Answer call
      await $(find.widgetWithIcon(TextButton, Icons.call)).tap();
      await pumpFor(const Duration(seconds: 3), $);
      expect(find.textContaining('00:0'), findsOneWidget, reason: 'Call should be active after answer');

      // Hangup call
      await pjsuaCallServerClient.hangup(pid);
      await pumpFor(const Duration(seconds: 3), $);
      expect($(CallActiveScaffold).visible, false, reason: 'Call should be ended after remote hangup');

      await Future.delayed(crossCallSleep);
    },
    skip: hasCredsToRunThisTest == false,
  );
}
