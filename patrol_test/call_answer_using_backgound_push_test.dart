import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/features/call/view/call_active_scaffold.dart';
import 'package:webtrit_phone/features/login/view/login_mode_select_screen.dart';

import 'components/integration_test_environment_config.dart';
import 'subsequences/login_by_method.dart';
import 'subsequences/logout.dart';
import 'subsequences/pump_for.dart';
import 'subsequences/pump_root_and_wait_until_visible.dart';
import 'package:pjsua_companion/pjsua_companion.dart';

void main() {
  final defaultLoginMethod = IntegrationTestEnvironmentConfig.DEFAULT_LOGIN_METHOD;
  const calleeNumber = IntegrationTestEnvironmentConfig.ACCOUNT_MAIN_NUMBER;

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

  patrolTest('Should go to background and wait for call > '
      'answer incoming call using push notification > '
      'verify call established > '
      'check active call push notification > '
      'hangup call using push notification button', ($) async {
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

    /// Go to background
    await $.platform.mobile.pressHome();

    // Place call
    await placeIncomingCall($);
    await Future.delayed(const Duration(seconds: 3));

    // Verify incoming call push notification
    final incomingCallNotification = await $.platform.mobile.getNotifications();
    print(incomingCallNotification);
    expect(
      incomingCallNotification.toString(),
      contains('You have an incoming call from'),
      reason: 'Incoming call push should exist and text ok',
    );

    // Try to answer call using push notification
    await $.platform.mobile.openNotifications();
    await $.platform.mobile.tapOnNotificationBySelector(Selector(textContains: 'Answer'));
    await $.platform.mobile.closeNotifications();
    await pumpFor(const Duration(seconds: 3), $);
    expect(find.textContaining('00:0'), findsOneWidget, reason: 'Call should be active after answer');

    // Verify active call push notification
    await $.platform.mobile.openNotifications();
    final activeCallNotifications = await $.platform.mobile.getNotifications();

    expect(
      activeCallNotifications.toString(),
      contains('Active call'),
      reason: 'Active call push should exist and text ok',
    );

    // Try to hangup call using push notification
    // Atention: If you have failed on this step, please check if all device notifications cleaned and re run test
    // because android for example ofter bundles many notifications and hangup button collapsed
    // TODO: find workaround
    await $.platform.mobile.tapOnNotificationBySelector(Selector(textContains: 'Hung up'));
    await $.platform.mobile.closeNotifications();
    await pumpFor(const Duration(seconds: 3), $);
    expect($(CallActiveScaffold).visible, false, reason: 'Call should be ended after remote hangup');

    // Teardowning
    await logout($);
  }, skip: hasCredsToRunThisTest == false);
}
