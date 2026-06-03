import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:pjsua_companion/pjsua_companion.dart';
import 'package:webtrit_phone/app/keys.dart';

import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/extensions/main_flavor.dart';
import 'package:webtrit_phone/features/call/view/call_active_scaffold.dart';
import 'package:webtrit_phone/features/login/view/login_mode_select_screen.dart';
import 'package:webtrit_phone/models/main_flavor.dart';
import 'package:webtrit_phone/widgets/call/call_tile.dart';

import 'components/integration_test_environment_config.dart';
import 'subsequences/login_by_method.dart';
import 'subsequences/logout.dart';
import 'subsequences/pump_for.dart';
import 'subsequences/pump_root_and_wait_until_visible.dart';

void main() {
  final defaultLoginMethod = IntegrationTestEnvironmentConfig.DEFAULT_LOGIN_METHOD;
  const mainNumber = IntegrationTestEnvironmentConfig.ACCOUNT_MAIN_NUMBER;

  final remoteSipServer = IntegrationTestEnvironmentConfig.PJSUA_SIP_SERVER;
  final pjsuaServerHost = IntegrationTestEnvironmentConfig.PJSUA_SERVER_HOST;
  final pjsuaServerPort = IntegrationTestEnvironmentConfig.PJSUA_SERVER_PORT;

  final contactAName = IntegrationTestEnvironmentConfig.EXT_CONTACT_A_UNIQUE_NAME;
  final contactANumber = IntegrationTestEnvironmentConfig.EXT_CONTACT_A_UNIQUE_NUMBER;
  final contactAExtension = IntegrationTestEnvironmentConfig.EXT_CONTACT_A_UNIQUE_EXT_NUMBER;
  final contactASipUsername = IntegrationTestEnvironmentConfig.EXT_CONTACT_A_SIP_USERNAME;
  final contactASipPassword = IntegrationTestEnvironmentConfig.EXT_CONTACT_A_SIP_PASSWORD;

  final contactBName = IntegrationTestEnvironmentConfig.EXT_CONTACT_B_UNIQUE_NAME;
  final contactBNumber = IntegrationTestEnvironmentConfig.EXT_CONTACT_B_UNIQUE_NUMBER;
  final contactBExtension = IntegrationTestEnvironmentConfig.EXT_CONTACT_B_UNIQUE_EXT_NUMBER;
  final contactBSipUsername = IntegrationTestEnvironmentConfig.EXT_CONTACT_B_SIP_USERNAME;
  final contactBSipPassword = IntegrationTestEnvironmentConfig.EXT_CONTACT_B_SIP_PASSWORD;

  final hasCredsToRunThisTest =
      pjsuaServerHost.isNotEmpty &&
      pjsuaServerPort != 0 &&
      contactASipUsername.isNotEmpty &&
      contactASipPassword.isNotEmpty &&
      remoteSipServer.isNotEmpty;

  patrolTest('Should make simple call and verify recents', ($) async {
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

    // Place incoming call and wait for it
    var companionPid = await pjsuaCallServerClient.call(
      mainNumber,
      sipServer: remoteSipServer,
      sipUsername: contactASipUsername,
      sipPassword: contactASipPassword,
    );
    await $(CallActiveScaffold).waitUntilVisible(timeout: const Duration(seconds: 10));
    await pumpFor(const Duration(seconds: 5), $);

    // Answer call
    await $(find.widgetWithIcon(TextButton, Icons.call)).tap();
    await pumpFor(const Duration(seconds: 3), $);
    expect(find.textContaining('00:0'), findsOneWidget, reason: 'Call should be active after answer');

    // Hangup call
    await pjsuaCallServerClient.hangup(companionPid);
    await pumpFor(const Duration(seconds: 3), $);
    expect($(CallActiveScaffold).visible, false, reason: 'Call should be ended after remote hangup');
    pjsuaCallServerClient.close(companionPid).ignore();

    // Check if the call is first in recents list.
    await $(MainFlavor.recents.toNavBarKey()).tap();
    expect(
      $(CallTile).at(0).containing(RegExp('$contactAExtension|$contactANumber')).containing(Icons.call_received),
      findsOne,
      reason: 'Should contain valid incoming call tile in recents list at first position',
    );

    // Place incoming call from contact B to main account
    companionPid = await pjsuaCallServerClient.call(
      mainNumber,
      sipServer: remoteSipServer,
      sipUsername: contactBSipUsername,
      sipPassword: contactBSipPassword,
    );
    await $(CallActiveScaffold).waitUntilVisible(timeout: const Duration(seconds: 10));
    await pumpFor(const Duration(seconds: 5), $);

    // Answer call
    await $(find.widgetWithIcon(TextButton, Icons.call)).tap();
    await pumpFor(const Duration(seconds: 3), $);
    expect(find.textContaining('00:0'), findsOneWidget, reason: 'Call should be active after answer');

    // Hangup call
    await pjsuaCallServerClient.hangup(companionPid);
    await pumpFor(const Duration(seconds: 3), $);
    expect($(CallActiveScaffold).visible, false, reason: 'Call should be ended after remote hangup');
    pjsuaCallServerClient.close(companionPid).ignore();

    // Check if the call is in the recents list and match previous calls position
    await $(MainFlavor.recents.toNavBarKey()).tap();
    expect(
      $(CallTile).at(0).containing(RegExp('$contactBExtension|$contactBNumber')).containing(Icons.call_received),
      findsOne,
      reason: 'Should contain valid incoming call tile in recents list at first position',
    );
    expect(
      $(CallTile).at(1).containing(RegExp('$contactAExtension|$contactANumber')).containing(Icons.call_received),
      findsOne,
      reason: 'Should contain valid incoming call tile in recents list at second position',
    );

    // Call back to A
    companionPid = await pjsuaCallServerClient.registerAutoanswer(
      sipServer: remoteSipServer,
      sipUsername: contactASipUsername,
      sipPassword: contactASipPassword,
    );
    await $(CallTile).at(1).tap();
    await $(CallActiveScaffold).waitUntilVisible(timeout: const Duration(seconds: 10));
    await pumpFor(const Duration(seconds: 5), $);
    expect(find.textContaining('00:0'), findsOneWidget, reason: 'Outgoing call should be connected');

    // Hangup call and check if it is done.
    await $(callActionsHangupKey).tap();
    await pumpFor(const Duration(seconds: 2), $);
    expect($(CallActiveScaffold).visible, false, reason: 'Call should be ended');
    pjsuaCallServerClient.close(companionPid).ignore();

    // Check if the call is in the recents list and match previous calls position
    await $(MainFlavor.recents.toNavBarKey()).tap();
    expect(
      $(CallTile).at(0).containing(RegExp('$contactAExtension|$contactANumber')).containing(Icons.call_made),
      findsOne,
      reason: 'Should contain valid outgoing call tile in recents list at first position',
    );
    expect(
      $(CallTile).at(1).containing(RegExp('$contactBExtension|$contactBNumber')).containing(Icons.call_received),
      findsOne,
      reason: 'Should contain valid incoming call tile in recents list at second position',
    );
    expect(
      $(CallTile).at(2).containing(RegExp('$contactAExtension|$contactANumber')).containing(Icons.call_received),
      findsOne,
      reason: 'Should contain valid incoming call tile in recents list at third position',
    );
    // Additionally verify A and B contact names
    expect($(CallTile).at(0).containing(RegExp(contactAName)), findsOne, reason: 'Should contain valid contact name');
    expect($(CallTile).at(1).containing(RegExp(contactBName)), findsOne, reason: 'Should contain valid contact name');
    expect($(CallTile).at(2).containing(RegExp(contactAName)), findsOne, reason: 'Should contain valid contact name');

    // Teardowning
    await logout($);
  }, skip: hasCredsToRunThisTest == false);
}
