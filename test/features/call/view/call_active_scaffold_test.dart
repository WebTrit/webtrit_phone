import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/features/call/view/call_active_scaffold.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/keypad_key_button.dart';

import 'call_active_scaffold_harness.dart';

void main() {
  late MockCallBloc callBloc;

  setUp(() {
    callBloc = newCallBloc();
    // This suite pins the PORTRAIT arrangement.
    pinPortraitSurface();
  });

  final ringing = makeCall(
    callId: 'ringing',
    processingStatus: CallProcessingStatus.incomingFromOffer,
    displayName: 'Anna Marchenko',
  );
  final active = makeCall(callId: 'active', acceptedTime: DateTime(2024), displayName: 'Boris Klein');

  group('CallActiveScaffold - single call (list of 1)', () {
    testWidgets('1 incoming: Decline/Answer only, no list, no hint', (tester) async {
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [ringing], focusedCall: ringing));

      expect(find.byType(IncomingCallActions), findsOneWidget);
      expect(find.byType(ActiveCallActions), findsNothing);
      expect(find.byType(CallList), findsNothing);
      expect(find.byType(FocusedActionHint), findsNothing);
      expect(find.byType(CallInfo), findsOneWidget);
      await teardownCallScaffold(tester);
    });

    testWidgets('1 active: control grid, no incoming actions, no list', (tester) async {
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [active], focusedCall: active));

      expect(find.byType(ActiveCallActions), findsOneWidget);
      expect(find.byType(IncomingCallActions), findsNothing);
      expect(find.byType(CallList), findsNothing);
      await teardownCallScaffold(tester);
    });

    testWidgets('1 on hold: control grid as well', (tester) async {
      final held = makeCall(callId: 'held', acceptedTime: DateTime(2024), held: true);
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [held], focusedCall: held));

      expect(find.byType(ActiveCallActions), findsOneWidget);
      expect(find.byType(IncomingCallActions), findsNothing);
      await teardownCallScaffold(tester);
    });
  });

  group('CallActiveScaffold - active + incoming', () {
    testWidgets('ringing focus: list + hint with hold side effect + two buttons', (tester) async {
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [active, ringing], focusedCall: ringing));
      final context = tester.element(find.byType(CallActiveScaffold));

      expect(find.byType(CallList), findsOneWidget);
      expect(find.byType(CallRow), findsNWidgets(2));
      expect(find.byType(IncomingCallActions), findsOneWidget);
      expect(find.byType(ActiveCallActions), findsNothing);
      // With multiple calls the rows carry the info; no central block.
      expect(find.byType(CallInfo), findsNothing);

      // The hint names the focused call and the answered call to be held.
      expect(
        find.text(context.l10n.call_FocusedActionHint_actingOn('Anna Marchenko'), findRichText: true),
        findsOneWidget,
      );
      expect(
        find.text(context.l10n.call_FocusedActionHint_willBeHeld('Boris Klein'), findRichText: true),
        findsOneWidget,
      );
      await teardownCallScaffold(tester);
    });

    testWidgets('answer dispatches the holding intent for the focused call', (tester) async {
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [active, ringing], focusedCall: ringing));

      await tester.tap(find.byIcon(Icons.call));
      verify(() => callBloc.add(const CallControlEvent.answeredHoldingOthers('ringing'))).called(1);
      await teardownCallScaffold(tester);
    });

    testWidgets('tapping the active row focuses it', (tester) async {
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [active, ringing], focusedCall: ringing));

      await tester.tap(find.byKey(const ValueKey('CallRow-active')));
      verify(() => callBloc.add(const CallControlEvent.callSelected('active'))).called(1);
      await teardownCallScaffold(tester);
    });

    testWidgets('active focus: control grid instead of incoming actions', (tester) async {
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [active, ringing], focusedCall: active));

      expect(find.byType(ActiveCallActions), findsOneWidget);
      expect(find.byType(IncomingCallActions), findsNothing);
      expect(find.byType(CallList), findsOneWidget);
      await teardownCallScaffold(tester);
    });
  });

  group('CallActiveScaffold - hold and resume on the focused call', () {
    testWidgets('Hold on an active focus holds just that call', (tester) async {
      final held = makeCall(callId: 'held', acceptedTime: DateTime(2024), held: true, displayName: 'Clara Diaz');
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [held, active], focusedCall: active));

      await tester.tap(find.byIcon(Icons.pause));
      verify(() => callBloc.add(const CallControlEvent.setHeld('active', true))).called(1);
      await teardownCallScaffold(tester);
    });

    testWidgets('Resume on a held focus holds the live call and resumes the focused one', (tester) async {
      final held = makeCall(callId: 'held', acceptedTime: DateTime(2024), held: true, displayName: 'Clara Diaz');
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [held, active], focusedCall: held));

      // The slot is a Resume affordance for a held focus - no swap button.
      expect(find.byIcon(Icons.swap_calls), findsNothing);
      await tester.tap(find.byIcon(Icons.play_arrow));
      verify(() => callBloc.add(const CallControlEvent.resumedHoldingOthers('held'))).called(1);
      await teardownCallScaffold(tester);
    });
  });

  group('CallActiveScaffold - camera permission denied', () {
    testWidgets('camera button shows the permission-denied tooltip', (tester) async {
      final call = makeCall(callId: 'active', acceptedTime: DateTime(2024), videoPermissionDenied: true);
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [call], focusedCall: call));
      final context = tester.element(find.byType(CallActiveScaffold));

      expect(find.byTooltip(context.l10n.call_CallActionsTooltip_cameraPermissionDenied), findsOneWidget);
      expect(find.byTooltip(context.l10n.call_CallActionsTooltip_enableCamera), findsNothing);
      await teardownCallScaffold(tester);
    });

    testWidgets('tap enables the camera when permission is now granted', (tester) async {
      final appPermissions = MockAppPermissions();
      when(() => appPermissions.isPermissionGranted(Permission.camera)).thenAnswer((_) async => true);
      final call = makeCall(callId: 'active', acceptedTime: DateTime(2024), videoPermissionDenied: true);
      await tester.pumpWidget(
        buildCallScaffold(callBloc, activeCalls: [call], focusedCall: call, appPermissions: appPermissions),
      );

      await tester.tap(find.byIcon(Icons.videocam_off));
      await tester.pump();

      verify(() => callBloc.add(const CallControlEvent.cameraEnabled('active', true))).called(1);
      verifyNever(() => appPermissions.toAppSettings());
      await teardownCallScaffold(tester);
    });

    testWidgets('tap opens app settings when permission is still denied', (tester) async {
      final appPermissions = MockAppPermissions();
      when(() => appPermissions.isPermissionGranted(Permission.camera)).thenAnswer((_) async => false);
      when(() => appPermissions.toAppSettings()).thenAnswer((_) async {});
      final call = makeCall(callId: 'active', acceptedTime: DateTime(2024), videoPermissionDenied: true);
      await tester.pumpWidget(
        buildCallScaffold(callBloc, activeCalls: [call], focusedCall: call, appPermissions: appPermissions),
      );

      await tester.tap(find.byIcon(Icons.videocam_off));
      await tester.pump();

      verify(() => appPermissions.toAppSettings()).called(1);
      await teardownCallScaffold(tester);
    });
  });

  group('CallActiveScaffold - attended transfer submit', () {
    final original = makeCall(callId: 'original', acceptedTime: DateTime(2024), held: true, displayName: 'Clara Diaz');
    final consultation = makeCall(
      callId: 'consultation',
      direction: CallDirection.outgoing,
      acceptedTime: DateTime(2024),
      displayName: 'Boris Klein',
    );

    Future<void> openTransferMenu(WidgetTester tester) async {
      await tester.tap(find.byKey(callActionsTransferMenuKey));
      await tester.pumpAndSettle();
    }

    // The replace target must always be the consultation call, regardless of
    // which row is focused - an incoming call grabs the selection at ring
    // time and keeps it, so the held original call may stay focused through
    // the whole transfer flow. A self-referential transfer (referor ==
    // replace) is rejected by the backend.
    for (final focused in [consultation, original]) {
      testWidgets('submit targets the consultation call when ${focused.callId} is focused', (tester) async {
        await tester.pumpWidget(
          buildCallScaffold(callBloc, activeCalls: [original, consultation], focusedCall: focused),
        );

        await openTransferMenu(tester);
        await tester.tap(find.byKey(callActionsTransferMenuNumberKey));
        await tester.pumpAndSettle();

        verify(
          () => callBloc.add(
            CallControlEvent.attendedTransferSubmitted(referorCall: original, replaceCall: consultation),
          ),
        ).called(1);
        await teardownCallScaffold(tester);
      });
    }

    testWidgets('attended item is absent while the consultation call is not yet accepted', (tester) async {
      final ringingConsultation = makeCall(
        callId: 'consultation',
        direction: CallDirection.outgoing,
        displayName: 'Boris Klein',
      );
      await tester.pumpWidget(
        buildCallScaffold(callBloc, activeCalls: [original, ringingConsultation], focusedCall: original),
      );

      await openTransferMenu(tester);

      expect(find.byKey(callActionsTransferMenuNumberKey), findsNothing);
      await teardownCallScaffold(tester);
    });
  });

  group('CallActiveScaffold - avatar in the video area', () {
    testWidgets('audio-only call shows the remote avatar instead of the video overlay', (tester) async {
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [active], focusedCall: active));

      expect(find.byType(CallRemoteAvatar), findsOneWidget);
      expect(find.byType(RemoteVideoViewOverlay), findsNothing);
      await teardownCallScaffold(tester);
    });

    testWidgets('falls back to the initials of the remote display name', (tester) async {
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [active], focusedCall: active));
      await tester.pump();

      expect(find.descendant(of: find.byType(CallRemoteAvatar), matching: find.text('BK')), findsOneWidget);
      await teardownCallScaffold(tester);
    });

    testWidgets('with a held call focused, the avatar shows that call, not the live one', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);

      final held = makeCall(callId: 'held', acceptedTime: DateTime(2024), held: true, displayName: 'Clara Diaz');
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [held, active], focusedCall: held));
      await tester.pump();

      // The roster highlights Clara and the actions act on her - the picture
      // must not show Boris (the derived current call) at the same time.
      expect(find.descendant(of: find.byType(CallRemoteAvatar), matching: find.text('CD')), findsOneWidget);
      await teardownCallScaffold(tester);
    });

    testWidgets('the open in-call keypad hides the avatar and keeps the keys full size', (tester) async {
      // The in-call keypad opens only in portrait orientation.
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [active], focusedCall: active));
      expect(find.byType(CallRemoteAvatar), findsOneWidget);

      await tester.tap(find.byKey(callActionsKeypadKey));
      await tester.pumpAndSettle();

      // The avatar makes way for the keypad, and the keys render at their
      // natural size (screen shortest side / 5) - never scaled down.
      expect(find.byType(CallRemoteAvatar), findsNothing);
      final keySize = tester.getSize(find.byType(KeypadKeyButton).first);
      expect(keySize.width, greaterThanOrEqualTo(360 / 5));

      await tester.tap(find.byKey(callActionsHideKeypadKey));
      await tester.pumpAndSettle();
      expect(find.byType(KeypadKeyButton), findsNothing);
      expect(find.byType(CallRemoteAvatar), findsOneWidget);

      await teardownCallScaffold(tester);
    });
  });

  group('CallActiveScaffold - 3 calls (held + active + incoming)', () {
    testWidgets('three rows, ringing focus keeps two buttons and the hint', (tester) async {
      final held = makeCall(callId: 'held', acceptedTime: DateTime(2024), held: true, displayName: 'Clara Diaz');
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [held, active, ringing], focusedCall: ringing));
      final context = tester.element(find.byType(CallActiveScaffold));

      expect(find.byType(CallRow), findsNWidgets(3));
      expect(find.byType(IncomingCallActions), findsOneWidget);
      // Only the still-active call is named in the hold side effect; the
      // already-held one does not change state.
      expect(
        find.text(context.l10n.call_FocusedActionHint_willBeHeld('Boris Klein'), findRichText: true),
        findsOneWidget,
      );
      await teardownCallScaffold(tester);
    });
  });

  group('CallActiveScaffold - hiding the controls in a video call', () {
    // What hiding them costs a screen reader is checked next door, in
    // call_active_scaffold_semantics_test.dart.
    const idleDelay = Duration(seconds: 8);

    testWidgets('on their own they hide once the call is left alone', (tester) async {
      final call = VideoCall();
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [call], focusedCall: call));

      expect(controlsOpacity(tester), 1);
      await tester.pump(idleDelay);
      expect(controlsOpacity(tester), 0);
      await teardownCallScaffold(tester);
    });

    testWidgets('a tap anywhere shows and hides them again', (tester) async {
      final call = VideoCall();
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [call], focusedCall: call));

      await tester.tapAt(const Offset(20, 400));
      await tester.pump(kThemeAnimationDuration);
      expect(controlsOpacity(tester), 0);

      await tester.tapAt(const Offset(20, 400));
      await tester.pump(kThemeAnimationDuration);
      expect(controlsOpacity(tester), 1);
      await teardownCallScaffold(tester);
    });

    testWidgets('the tap works the same with no video to tap on', (tester) async {
      // An audio call has no video layer at all, and a ringing one is not even
      // connected - the tap still belongs to the whole screen.
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [ringing], focusedCall: ringing));

      await tester.tapAt(const Offset(20, 400));
      await tester.pump(kThemeAnimationDuration);
      expect(controlsOpacity(tester, of: find.byType(IncomingCallActions)), 0);
      await teardownCallScaffold(tester);
    });

    testWidgets('the bare toolbar counts as anywhere too', (tester) async {
      // The toolbar carries the status line and nothing else to press, so a tap
      // on it belongs to the same gesture as a tap on the picture.
      final call = VideoCall();
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [call], focusedCall: call));

      await tester.tapAt(tester.getCenter(find.byType(AppBar)));
      await tester.pump(kThemeAnimationDuration);
      expect(controlsOpacity(tester), 0);
      await teardownCallScaffold(tester);
    });

    testWidgets('the demand arriving over hidden controls brings them back', (tester) async {
      final call = VideoCall();
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [call], focusedCall: call));
      await tester.pump(idleDelay);
      expect(controlsOpacity(tester), 0);

      await tester.pumpWidget(
        buildCallScaffold(callBloc, activeCalls: [call], focusedCall: call, keepControlsVisible: true),
      );
      await tester.pump(kThemeAnimationDuration);
      expect(controlsOpacity(tester), 1);
      await teardownCallScaffold(tester);
    });
  });
}
