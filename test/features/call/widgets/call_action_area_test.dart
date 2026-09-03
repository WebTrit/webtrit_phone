import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

import '../view/call_active_scaffold_harness.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    );
  }

  Widget buildArea({
    required List<ActiveCall> activeCalls,
    required ActiveCall focusedCall,
    CallCapabilitiesConfig callConfig = const CallCapabilitiesConfig(),
    bool interactionsEnabled = true,
    VoidCallback? onHangup,
    VoidCallback? onAccept,
  }) {
    return CallActionArea(
      activeCalls: activeCalls,
      focusedCall: focusedCall,
      audioDevice: null,
      availableAudioDevices: const [],
      callConfig: callConfig,
      keypadShown: false,
      interactionsEnabled: interactionsEnabled,
      onKeypadToggle: (_) {},
      onCameraChanged: (_) {},
      onCameraPermissionDeniedPressed: () {},
      onMutedChanged: (_) {},
      onAudioDeviceChanged: (_) {},
      onBlindTransferInitiated: () {},
      onAttendedTransferInitiated: () {},
      onAttendedTransferSubmitted: (_) {},
      onHeldChanged: (_) {},
      onKeyPressed: (_) {},
      onHangup: onHangup ?? () {},
      onAccept: onAccept ?? () {},
    );
  }

  /// The button that owns [icon] - the way to reach whether it is pressable.
  TextButton buttonWithIcon(WidgetTester tester, IconData icon) {
    return tester.widget<TextButton>(find.ancestor(of: find.byIcon(icon), matching: find.byType(TextButton)).first);
  }

  final active = makeCall(callId: 'active', acceptedTime: DateTime(2024), displayName: 'Boris Klein');
  final ringing = makeCall(
    callId: 'ringing',
    processingStatus: CallProcessingStatus.incomingFromOffer,
    displayName: 'Anna Marchenko',
  );
  final outgoingRinging = makeCall(
    callId: 'outgoing',
    direction: CallDirection.outgoing,
    processingStatus: CallProcessingStatus.outgoingCreated,
    displayName: 'Dana Weber',
  );

  group('CallActionArea - which actions are offered', () {
    testWidgets('a live focus gets the control grid, and its hangup fires the callback', (tester) async {
      var hangups = 0;
      await tester.pumpWidget(wrap(buildArea(activeCalls: [active], focusedCall: active, onHangup: () => hangups++)));

      expect(find.byType(ActiveCallActions), findsOneWidget);
      expect(find.byType(IncomingCallActions), findsNothing);

      await tester.tap(find.byIcon(Icons.call_end));
      expect(hangups, 1);
    });

    testWidgets('a ringing focus gets Decline/Answer only, with no hint while it is the only call', (tester) async {
      var accepts = 0;
      await tester.pumpWidget(wrap(buildArea(activeCalls: [ringing], focusedCall: ringing, onAccept: () => accepts++)));

      expect(find.byType(IncomingCallActions), findsOneWidget);
      expect(find.byType(ActiveCallActions), findsNothing);
      expect(find.byType(FocusedActionHint), findsNothing);

      await tester.tap(find.byIcon(Icons.call));
      expect(accepts, 1);
    });
  });

  group('CallActionArea - the hint spells the side effect of answering', () {
    testWidgets('an answered other call will be held', (tester) async {
      await tester.pumpWidget(wrap(buildArea(activeCalls: [active, ringing], focusedCall: ringing)));
      final context = tester.element(find.byType(CallActionArea));

      expect(
        find.text(context.l10n.call_FocusedActionHint_actingOn('Anna Marchenko'), findRichText: true),
        findsOneWidget,
      );
      expect(
        find.text(context.l10n.call_FocusedActionHint_willBeHeld('Boris Klein'), findRichText: true),
        findsOneWidget,
      );
    });

    testWidgets('an other call that cannot be held will be ended', (tester) async {
      // The only other call is still ringing itself - nothing to hold, so
      // answering ends it, and the hint has to say so.
      await tester.pumpWidget(wrap(buildArea(activeCalls: [outgoingRinging, ringing], focusedCall: ringing)));
      final context = tester.element(find.byType(CallActionArea));

      expect(
        find.text(context.l10n.call_FocusedActionHint_willBeEnded('Dana Weber'), findRichText: true),
        findsOneWidget,
      );
      expect(find.text(context.l10n.call_FocusedActionHint_willBeHeld('Dana Weber'), findRichText: true), findsNothing);
    });
  });

  group('CallActionArea - gating', () {
    testWidgets('answering that mutates other calls waits out the interaction debounce', (tester) async {
      await tester.pumpWidget(
        wrap(buildArea(activeCalls: [active, ringing], focusedCall: ringing, interactionsEnabled: false)),
      );

      // With no accept callback the button is not rendered at all (see
      // IncomingCallActions); declining stays available throughout.
      expect(find.byIcon(Icons.call), findsNothing);
      expect(buttonWithIcon(tester, Icons.call_end).onPressed, isNotNull);
    });

    testWidgets('answering the only call ignores the debounce - nothing else is mutated', (tester) async {
      await tester.pumpWidget(
        wrap(buildArea(activeCalls: [ringing], focusedCall: ringing, interactionsEnabled: false)),
      );

      expect(buttonWithIcon(tester, Icons.call).onPressed, isNotNull);
    });

    testWidgets('disabling video calls in the config disables the camera button', (tester) async {
      await tester.pumpWidget(
        wrap(
          buildArea(
            activeCalls: [active],
            focusedCall: active,
            callConfig: const CallCapabilitiesConfig(isVideoCallEnabled: false),
          ),
        ),
      );

      expect(buttonWithIcon(tester, Icons.videocam_off).onPressed, isNull);
    });

    testWidgets('transfer is not offered while the focused call was never accepted', (tester) async {
      await tester.pumpWidget(wrap(buildArea(activeCalls: [outgoingRinging], focusedCall: outgoingRinging)));

      expect(buttonWithIcon(tester, Icons.phone_forwarded).onPressed, isNull);
    });

    testWidgets('transfer is offered on an accepted focus', (tester) async {
      await tester.pumpWidget(wrap(buildArea(activeCalls: [active], focusedCall: active)));

      expect(buttonWithIcon(tester, Icons.phone_forwarded).onPressed, isNotNull);
    });
  });
}
