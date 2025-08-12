import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/features/call/view/call_active_thumbnail.dart';
import 'package:webtrit_phone/models/main_flavor.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/call/view/call_active_scaffold.dart';
import 'package:webtrit_phone/features/login/view/login_mode_select_screen.dart';

import 'components/integration_test_environment_config.dart';
import 'subsequences/enter_keypad_number.dart';
import 'subsequences/login_by_method.dart';
import 'subsequences/pump_for.dart';
import 'subsequences/pump_root_and_wait_until_visible.dart';

main() {
  final defaultLoginMethod = IntegrationTestEnvironmentConfig.DEFAULT_LOGIN_METHOD;
  const callNumber = IntegrationTestEnvironmentConfig.CALL_NUMBER_A;
  const crossCallSleep = Duration(seconds: IntegrationTestEnvironmentConfig.CROSS_CALL_SLEEP_SECONDS);

  patrolTest(
    'Should make call and verify sub actions e.g minimize, hold, switch to video, speaker, mute etc',
    ($) async {
      await bootstrap();
      await pumpRootAndWaitUntilVisible($);

      // Login if not.
      if ($(LoginModeSelectScreen).visible) {
        await loginByMethod($, defaultLoginMethod);
        // Wait some time for components loading and session establishment.
        await pumpFor(const Duration(seconds: 5), $);
      }

      // Make a call and check if it is active.
      await $(MainFlavor.keypad.toNavBarKey()).tap();
      await enterKeypadNumber($, callNumber);
      await $(actionPadStartKey).tap();
      await $(CallActiveScaffold).waitUntilVisible();
      await pumpFor(const Duration(seconds: 5), $);
      expect(find.textContaining('00:0'), findsOneWidget, reason: 'Call should be active');

      // Minimize call and check if it is minimized.
      await $.native.pressBack();
      await pumpFor(const Duration(seconds: 1), $);
      expect($(CallActiveScaffold).visible, false, reason: 'Call should be minimized');
      expect($(CallActiveThumbnail), findsOneWidget, reason: 'Thumbnail should be visible');
      await $(CallActiveThumbnail).tap();
      await pumpFor(const Duration(seconds: 1), $);
      expect($(CallActiveScaffold).visible, true, reason: 'Call should be active');
      expect($(CallActiveThumbnail), findsNothing, reason: 'Thumbnail should disappear');

      // Check mute function
      await $(callActionsMuteKey).tap();
      await pumpFor(const Duration(seconds: 1), $);
      expect(find.widgetWithIcon(TextButton, Icons.mic_off), findsOneWidget, reason: 'Call should be muted');
      await $(callActionsMuteKey).tap();
      await pumpFor(const Duration(seconds: 1), $);
      expect(find.widgetWithIcon(TextButton, Icons.mic), findsOneWidget, reason: 'Call should be unmuted');

      // Check speaker function
      await $(callActionsSpeakerKey).tap();
      await pumpFor(const Duration(seconds: 1), $);
      expect(find.widgetWithIcon(TextButton, Icons.volume_up), findsOneWidget, reason: 'Speaker should be on');
      await $(callActionsSpeakerKey).tap();
      await pumpFor(const Duration(seconds: 1), $);
      expect(find.widgetWithIcon(TextButton, Icons.volume_off), findsOneWidget, reason: 'Speaker should be off');

      // Check hold function
      await $(callActionsHoldKey).tap();
      await pumpFor(const Duration(seconds: 1), $);
      expect(find.text('On hold'), findsOneWidget, reason: 'Call should be on hold');
      await $(callActionsHoldKey).tap();
      await pumpFor(const Duration(seconds: 1), $);
      expect(find.textContaining('00:'), findsOneWidget, reason: 'Call should be active again');

      // Check switch to video function
      await $(callActionsVideoCallKey).tap();
      await pumpFor(const Duration(seconds: 2), $);
      expect($(callFrontCameraPreviewKey), findsOneWidget, reason: 'Front camera frame should appear');
      final rtcRenderersWithData = $(RTCVideoView).which(
        (RTCVideoView widget) => widget.videoRenderer.videoValue.renderVideo == true,
      );
      expect(rtcRenderersWithData, findsOneWidget, reason: 'Check video renderer');

      // Hangup call and check if it is done.
      await $(callActionsHangupKey).tap();
      await pumpFor(const Duration(seconds: 2), $);
      expect($(CallActiveScaffold).visible, false, reason: 'Call should be ended');

      await Future.delayed(crossCallSleep);
    },
  );
}
