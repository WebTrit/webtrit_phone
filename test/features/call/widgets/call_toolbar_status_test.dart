import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

Widget _buildSubject({
  required CallStatus callStatus,
  CallNetworkQuality? networkQuality,
  IceConnectionIssue? iceConnectionIssue,
}) {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      body: CallToolbarStatus(
        callStatus: callStatus,
        networkQuality: networkQuality,
        iceConnectionIssue: iceConnectionIssue,
      ),
    ),
  );
}

const _quality = CallNetworkQuality(
  severity: CallNetworkQualitySeverity.severe,
  uplink: true,
  media: CallMediaKind.audio,
);

void main() {
  group('CallToolbarStatus', () {
    testWidgets('renders nothing while everything is healthy', (tester) async {
      await tester.pumpWidget(_buildSubject(callStatus: CallStatus.ready));
      expect(find.byType(Text), findsNothing);
    });

    testWidgets('no internet: hard state with its own message only', (tester) async {
      await tester.pumpWidget(_buildSubject(callStatus: CallStatus.connectivityNone));
      final context = tester.element(find.byType(CallToolbarStatus));

      expect(find.text(context.l10n.callStatus_connectivityNone), findsOneWidget);
      expect(find.text(context.l10n.call_ToolbarStatus_reconnecting), findsNothing);
      expect(find.text(context.l10n.call_ToolbarStatus_connecting), findsNothing);
    });

    testWidgets('unregistered: hard state with its own message', (tester) async {
      await tester.pumpWidget(_buildSubject(callStatus: CallStatus.appUnregistered));
      final context = tester.element(find.byType(CallToolbarStatus));

      expect(find.text(context.l10n.callStatus_appUnregistered), findsOneWidget);
    });

    testWidgets('first connection shows Connecting', (tester) async {
      await tester.pumpWidget(_buildSubject(callStatus: CallStatus.inProgress));
      final context = tester.element(find.byType(CallToolbarStatus));

      expect(find.text(context.l10n.call_ToolbarStatus_connecting), findsOneWidget);
      expect(find.text(context.l10n.call_ToolbarStatus_reconnecting), findsNothing);
    });

    testWidgets('a drop after being connected shows Reconnecting (debounced)', (tester) async {
      await tester.pumpWidget(_buildSubject(callStatus: CallStatus.ready));
      await tester.pumpWidget(_buildSubject(callStatus: CallStatus.connectError));
      // Transient statuses are debounced to avoid reconnect-backoff flicker.
      await tester.pump(kSignalingStatusDebounce + const Duration(milliseconds: 50));
      final context = tester.element(find.byType(CallToolbarStatus));

      expect(find.text(context.l10n.call_ToolbarStatus_reconnecting), findsOneWidget);
      expect(find.text(context.l10n.call_ToolbarStatus_connecting), findsNothing);
      // Stop the pulsing dot animation cleanly.
      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('network quality: bars + arrow + always-visible label, no media glyph', (tester) async {
      await tester.pumpWidget(_buildSubject(callStatus: CallStatus.ready, networkQuality: _quality));
      final context = tester.element(find.byType(CallToolbarStatus));

      expect(find.byType(CallNetworkQualityMeter), findsOneWidget);
      // The toolbar renders the label itself; the meter label is suppressed,
      // so the text appears exactly once even at severe.
      expect(find.text(context.l10n.callNetworkQuality_yourAudioWeak), findsOneWidget);
      // Direction arrow stays, the mic/camera glyph does not (the label
      // already says audio/video).
      expect(find.byIcon(Icons.north), findsOneWidget);
      expect(find.byIcon(Icons.mic), findsNothing);
    });

    testWidgets('quality label is visible below severe too', (tester) async {
      const mild = CallNetworkQuality(
        severity: CallNetworkQualitySeverity.mild,
        uplink: false,
        media: CallMediaKind.audio,
      );
      await tester.pumpWidget(_buildSubject(callStatus: CallStatus.ready, networkQuality: mild));
      final context = tester.element(find.byType(CallToolbarStatus));

      expect(find.text(context.l10n.callNetworkQuality_theirAudioWeak), findsOneWidget);
    });

    testWidgets('connectivity trouble wins over network quality', (tester) async {
      await tester.pumpWidget(_buildSubject(callStatus: CallStatus.connectivityNone, networkQuality: _quality));
      final context = tester.element(find.byType(CallToolbarStatus));

      expect(find.text(context.l10n.callStatus_connectivityNone), findsOneWidget);
      expect(find.byType(CallNetworkQualityMeter), findsNothing);
    });

    testWidgets('a media failure wins over network quality', (tester) async {
      await tester.pumpWidget(
        _buildSubject(
          callStatus: CallStatus.ready,
          networkQuality: _quality,
          iceConnectionIssue: IceConnectionIssue.iceFail,
        ),
      );
      final context = tester.element(find.byType(CallToolbarStatus));

      expect(find.text(context.l10n.iceConnectionIssue_iceFail), findsOneWidget);
      expect(find.byType(CallNetworkQualityMeter), findsNothing);
    });
  });
}
