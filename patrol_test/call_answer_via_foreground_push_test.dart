import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/features/login/view/login_mode_select_screen.dart';

import 'components/integration_test_environment_config.dart';
import 'subsequences/active_call_helpers.dart';
import 'subsequences/login_by_method.dart';
import 'subsequences/logout.dart';
import 'subsequences/pump_for.dart';
import 'subsequences/pump_root_and_wait_until_visible.dart';
import 'package:pjsua_companion/pjsua_companion.dart';

void main() {
  final defaultLoginMethod = IntegrationTestEnvironmentConfig.DEFAULT_LOGIN_METHOD;
  const mainNumber = IntegrationTestEnvironmentConfig.ACCOUNT_MAIN_NUMBER;

  final remoteUser = IntegrationTestEnvironmentConfig.EXT_CONTACT_A_SIP_USERNAME;
  final remoteSipServer = IntegrationTestEnvironmentConfig.PJSUA_SIP_SERVER;
  final remotePassword = IntegrationTestEnvironmentConfig.EXT_CONTACT_A_SIP_PASSWORD;
  final pjsuaServerHost = IntegrationTestEnvironmentConfig.PJSUA_SERVER_HOST;
  final pjsuaServerPort = IntegrationTestEnvironmentConfig.PJSUA_SERVER_PORT;

  final hasCredsToRunThisTest =
      remoteUser.isNotEmpty &&
      remoteSipServer.isNotEmpty &&
      remotePassword.isNotEmpty &&
      pjsuaServerHost.isNotEmpty &&
      pjsuaServerPort != 0;

  patrolTest('Verifies answer on incoming call using foreground push function', ($) async {
    /// Prepare
    final pjsuaCallServerClient = PjsuaCompanionClient(host: pjsuaServerHost, port: pjsuaServerPort);

    final instanceRegistry = await bootstrap();
    await pumpRootAndWaitUntilVisible(instanceRegistry, $);

    //// Test

    // Login if not.
    if ($(LoginModeSelectScreen).visible) {
      await loginByMethod($, defaultLoginMethod);
      // Wait some time for components loading and session establishment.
      await pumpFor(const Duration(seconds: 5), $);
    }

    // Place call
    final companionPid = await pjsuaCallServerClient.call(
      mainNumber,
      sipServer: remoteSipServer,
      sipUsername: remoteUser,
      sipPassword: remotePassword,
    );
    await Future.delayed(const Duration(seconds: 3));

    // Verify incoming call push notification
    final incomingCallNotification = await $.platform.mobile.getNotifications();
    expect(
      incomingCallNotification.toString(),
      contains('You have an incoming call from'),
      reason: 'Incoming call push should exist and text ok',
    );

    // Try to answer call using push notification
    await $.platform.mobile.openNotifications();
    await $.platform.mobile.tapOnNotificationBySelector(Selector(textContains: 'Answer'));
    await $.platform.mobile.closeNotifications();
    await expectActiveCallDurationGte(const Duration(seconds: 3), $);

    // Hangup call
    await pjsuaCallServerClient.hangup(companionPid);
    await expectActiveCallHangup($);

    // Teardowning
    pjsuaCallServerClient.close(companionPid).ignore();
    await logout($);
  }, skip: hasCredsToRunThisTest == false);
}
