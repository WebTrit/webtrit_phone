import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/keypad_key_button.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';

import '../../../helpers/helpers.dart';

final _transferableCall = ActiveCall(
  callId: 'transferable',
  direction: CallDirection.incoming,
  line: 0,
  handle: const CallkeepHandle.number('1002'),
  createdTime: DateTime(2024),
  video: false,
  processingStatus: CallProcessingStatus.connected,
  acceptedTime: DateTime(2024),
);

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    );
  }

  Widget buildActive({
    bool enableInteractions = true,
    ValueChanged<bool>? onMutedChanged,
    ValueChanged<bool>? onHeldChanged,
    VoidCallback? onHangupPressed,
    VoidCallback? onBlindTransferInitiated,
    VoidCallback? onAttendedTransferInitiated,
    List<ActiveCall> transferableCalls = const [],
    void Function(String)? onKeyPressed,
    bool mutedValue = false,
    bool keypadShown = false,
    ValueChanged<bool>? onKeypadToggle,
  }) {
    return ActiveCallActions(
      keypadShown: keypadShown,
      onKeypadToggle: onKeypadToggle,
      enableInteractions: enableInteractions,
      isIncoming: false,
      wasAccepted: true,
      wasHungUp: false,
      cameraValue: false,
      inviteToAttendedTransfer: false,
      mutedValue: mutedValue,
      onMutedChanged: onMutedChanged,
      audioDevice: const CallAudioDevice(type: CallAudioDeviceType.earpiece),
      availableAudioDevices: const [
        CallAudioDevice(type: CallAudioDeviceType.earpiece),
        CallAudioDevice(type: CallAudioDeviceType.speaker),
      ],
      onAudioDeviceChanged: (_) {},
      transferableCalls: transferableCalls,
      onBlindTransferInitiated: onBlindTransferInitiated,
      onAttendedTransferInitiated: onAttendedTransferInitiated,
      onAttendedTransferSubmitted: null,
      heldValue: false,
      onHeldChanged: onHeldChanged,
      onHangupPressed: onHangupPressed,
      onKeyPressed: onKeyPressed,
    );
  }

  group('ActiveCallActions accessibility', () {
    testWidgets('mute, hold and hangup announce themselves and activate through semantics', (tester) async {
      final handle = tester.ensureSemantics();

      bool? muted;
      bool? held;
      var hungUp = false;
      await tester.pumpWidget(
        wrap(
          buildActive(
            onMutedChanged: (v) => muted = v,
            onHeldChanged: (v) => held = v,
            onHangupPressed: () => hungUp = true,
          ),
        ),
      );

      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(callActionsMuteId),
        label: 'Mute microphone',
        identifier: callActionsMuteId,
        isButton: true,
      );
      await tapViaSemantics(tester, find.bySemanticsIdentifier(callActionsMuteId));
      expect(muted, isTrue);

      expectTapTargetSemantics(tester, find.bySemanticsIdentifier(callActionsHoldId), label: 'Hold call');
      await tapViaSemantics(tester, find.bySemanticsIdentifier(callActionsHoldId));
      expect(held, isTrue);

      expectTapTargetSemantics(tester, find.bySemanticsIdentifier(callActionsHangupId), label: 'Hangup');
      await tapViaSemantics(tester, find.bySemanticsIdentifier(callActionsHangupId));
      expect(hungUp, isTrue);

      handle.dispose();
    });

    testWidgets('muted state flips the spoken name', (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(wrap(buildActive(mutedValue: true, onMutedChanged: (_) {})));

      expectTapTargetSemantics(tester, find.bySemanticsIdentifier(callActionsMuteId), label: 'Unmute microphone');

      handle.dispose();
    });

    testWidgets('transfer trigger opens its menu through semantics', (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(wrap(buildActive(onBlindTransferInitiated: () {}, onAttendedTransferInitiated: () {})));

      final transfer = find.bySemanticsIdentifier(callActionsTransferMenuId);
      expectTapTargetSemantics(tester, transfer, label: 'Transfer', isButton: true);

      await tapViaSemantics(tester, transfer);
      await tester.pumpAndSettle();

      expect(find.text('Unattended transfer'), findsOneWidget);
      expect(find.text('Attended transfer'), findsOneWidget);

      handle.dispose();
    });

    testWidgets('in-call keypad: digits enter through semantics and hide button is named', (tester) async {
      final handle = tester.ensureSemantics();

      // The in-call keypad opens only in portrait orientation.
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);

      final entered = <String>[];
      // The keypad visibility is owned by the parent (the call screen); the
      // harness plays that role.
      var keypadShown = false;
      await tester.pumpWidget(
        wrap(
          StatefulBuilder(
            builder: (context, setState) => buildActive(
              onKeyPressed: entered.add,
              keypadShown: keypadShown,
              onKeypadToggle: (shown) => setState(() => keypadShown = shown),
            ),
          ),
        ),
      );

      await tapViaSemantics(tester, find.bySemanticsIdentifier(callActionsKeypadId));
      await tester.pumpAndSettle();

      await tapViaSemantics(tester, find.bySemanticsIdentifier(keypadKeyId('5')));
      expect(entered, ['5']);

      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(callActionsHideKeypadId),
        label: 'Hide keypad',
        isButton: true,
      );

      handle.dispose();
    });
  });

  group('ActiveCallActions while interactions are blocked', () {
    testWidgets('a keypad key press is ignored instead of crashing', (tester) async {
      final handle = tester.ensureSemantics();

      // The in-call keypad opens only in portrait orientation.
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);

      final entered = <String>[];
      // The keypad stays open across a renegotiation window: it is opened
      // while interactions are allowed and blocked right after.
      var enableInteractions = true;
      await tester.pumpWidget(
        wrap(
          StatefulBuilder(
            builder: (context, setState) => buildActive(
              enableInteractions: enableInteractions,
              onKeyPressed: entered.add,
              keypadShown: true,
              onKeypadToggle: (_) {},
            ),
          ),
        ),
      );

      await tapViaSemantics(tester, find.bySemanticsIdentifier(keypadKeyId('5')));
      expect(entered, ['5']);

      enableInteractions = false;
      await tester.pumpWidget(
        wrap(buildActive(enableInteractions: false, onKeyPressed: entered.add, keypadShown: true)),
      );

      await tester.tap(find.byType(KeypadKeyButton).first);
      await tester.pump();
      expect(entered, ['5'], reason: 'the blocked press must not reach the call');
      expect(tester.takeException(), isNull);

      handle.dispose();
    });

    testWidgets('transfer trigger is disabled when no transfer intent is wired', (tester) async {
      final handle = tester.ensureSemantics();

      // Two calls make the "transfer to a call" branch render, but with no
      // transfer callbacks its menu would be empty.
      await tester.pumpWidget(wrap(buildActive(transferableCalls: [_transferableCall])));

      final node = tester.getSemantics(find.bySemanticsIdentifier(callActionsTransferMenuId));
      expect(node, isSemantics(label: 'Transfer', hasTapAction: false));

      handle.dispose();
    });
  });

  group('IncomingCallActions accessibility', () {
    testWidgets('decline and accept are named and activate through semantics', (tester) async {
      final handle = tester.ensureSemantics();

      var declined = false;
      var accepted = false;
      await tester.pumpWidget(
        wrap(
          IncomingCallActions(
            remoteVideo: false,
            inviteToAttendedTransfer: false,
            onHangupPressed: () => declined = true,
            onAcceptPressed: () => accepted = true,
          ),
        ),
      );

      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(callActionsHangupId),
        label: 'Hangup',
        identifier: callActionsHangupId,
        isButton: true,
      );
      await tapViaSemantics(tester, find.bySemanticsIdentifier(callActionsHangupId));
      expect(declined, isTrue);

      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(callActionsAcceptId),
        label: 'Accept',
        identifier: callActionsAcceptId,
        isButton: true,
      );
      await tapViaSemantics(tester, find.bySemanticsIdentifier(callActionsAcceptId));
      expect(accepted, isTrue);

      handle.dispose();
    });
  });
}
