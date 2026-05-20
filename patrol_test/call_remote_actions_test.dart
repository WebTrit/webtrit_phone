// ignore_for_file: unused_import

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/models/main_flavor.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/call/view/call_active_scaffold.dart';
import 'package:webtrit_phone/features/login/view/login_mode_select_screen.dart';

import 'components/integration_test_environment_config.dart';
import 'subsequences/enter_keypad_number.dart';
import 'subsequences/login_by_method.dart';
import 'subsequences/pump_for.dart';
import 'subsequences/pump_root_and_wait_until_visible.dart';
import 'tools/pjsua_call_server_client.dart';

void main() {
  final defaultLoginMethod = IntegrationTestEnvironmentConfig.DEFAULT_LOGIN_METHOD;
  const calleeNumber = IntegrationTestEnvironmentConfig.ACCOUNT_MAIN_NUMBER;

  final pjsuaCallServerClient = PjsuaCallServerClient(host: '192.168.31.226', port: 7788);

  patrolTest('Should login and answer on incoming call', ($) async {
    final instanceRegistry = await bootstrap();
    await pumpRootAndWaitUntilVisible(instanceRegistry, $);

    // Login if not.
    if ($(LoginModeSelectScreen).visible) {
      await loginByMethod($, defaultLoginMethod);
      // Wait some time for components loading and session establishment.
      await pumpFor(const Duration(seconds: 5), $);
    }

    // Ask the host-side pjsua server to place an incoming call to this account.
    // The host must be running: dart patrol_test/tools/pjsua_call_server.dart
    await pjsuaCallServerClient.call(calleeNumber, callDuration: const Duration(seconds: 10));

    // Wait for the call to appear in the UI.
    await $(CallActiveScaffold).waitUntilVisible(timeout: const Duration(seconds: 10));
    expect(find.textContaining('00:0'), findsOneWidget, reason: 'Call should be active');

    // Check if call is ended after 10 seconds.
    await Future.delayed(const Duration(seconds: 10));
    expect($(CallActiveScaffold).visible, false, reason: 'Call should be ended');

    // TODO:
    // - trigger hang up and wait for call to disappear
    // - analize rtp flow for audio and probe video frames to check remote mute and hold
    // - test transfers
    // - check upgrade to video
    // - check push notifications
  });
}
