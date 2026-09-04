import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/keypad_key_button.dart';

import 'call_active_scaffold_harness.dart';

/// The landscape arrangement of the call screen: three zones in one row -
/// info, the action grid, and the hangup standing apart. Portrait behaviour
/// is covered next door in call_active_scaffold_test.dart; these tests pin
/// what changes when the phone turns.
void main() {
  late MockCallBloc callBloc;

  setUp(() => callBloc = newCallBloc());

  final ringing = makeCall(
    callId: 'ringing',
    processingStatus: CallProcessingStatus.incomingFromOffer,
    displayName: 'Anna Marchenko',
  );
  final active = makeCall(callId: 'active', acceptedTime: DateTime(2024), displayName: 'Boris Klein');

  /// A real phone lying down (Pixel 9, 874x402 logical).
  void setLandscapePhoneSurface(WidgetTester tester) {
    tester.view.physicalSize = const Size(2622, 1206);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
  }

  group('CallActiveScaffold - landscape, single live call', () {
    testWidgets('info, grid and hangup stand in one row, in that order', (tester) async {
      setLandscapePhoneSurface(tester);
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [active], focusedCall: active));

      final infoDx = tester.getCenter(find.byType(CallInfo)).dx;
      final gridDx = tester.getCenter(find.byType(ActiveCallActions)).dx;
      final hangupDx = tester.getCenter(find.byKey(callActionsHangupKey)).dx;
      expect(infoDx, lessThan(gridDx));
      expect(gridDx, lessThan(hangupDx));

      // One row: the info block and the grid share the height, not the width.
      final infoDy = tester.getCenter(find.byType(CallInfo)).dy;
      final gridDy = tester.getCenter(find.byType(ActiveCallActions)).dy;
      expect((infoDy - gridDy).abs(), lessThan(100));

      await teardownCallScaffold(tester);
    });

    testWidgets('the hangup leaves the grid for a zone of its own', (tester) async {
      setLandscapePhoneSurface(tester);
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [active], focusedCall: active));

      // Exactly one hangup on screen, and the grid is not its home.
      expect(find.byKey(callActionsHangupKey), findsOneWidget);
      expect(
        find.descendant(of: find.byType(ActiveCallActions), matching: find.byKey(callActionsHangupKey)),
        findsNothing,
      );

      // It still ends the focused call.
      await tester.tap(find.byKey(callActionsHangupKey));
      expect(find.byKey(callActionsHangupKey), findsOneWidget);

      await teardownCallScaffold(tester);
    });

    testWidgets('the avatar stands beside the info instead of above it', (tester) async {
      setLandscapePhoneSurface(tester);
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [active], focusedCall: active));
      await tester.pump();

      final avatarCenter = tester.getCenter(find.byType(CallRemoteAvatar));
      final infoCenter = tester.getCenter(find.byType(CallInfo));
      expect(avatarCenter.dx, lessThan(infoCenter.dx));

      // Beside means beside: the name lines up with the avatar instead of
      // being pinned to the top of the zone while the avatar floats mid-air.
      final nameDy = tester.getCenter(find.text('Boris Klein')).dy;
      expect((nameDy - avatarCenter.dy).abs(), lessThan(60));

      await teardownCallScaffold(tester);
    });
  });

  group('CallActiveScaffold - landscape, several calls', () {
    testWidgets('the roster takes the info zone, left of the grid, with no avatar', (tester) async {
      setLandscapePhoneSurface(tester);
      final held = makeCall(callId: 'held', acceptedTime: DateTime(2024), held: true, displayName: 'Clara Diaz');
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [held, active], focusedCall: active));

      expect(find.byType(CallList), findsOneWidget);
      expect(find.byType(CallRow), findsNWidgets(2));
      expect(find.byType(CallRemoteAvatar), findsNothing);

      final rosterDx = tester.getCenter(find.byType(CallList)).dx;
      final gridDx = tester.getCenter(find.byType(ActiveCallActions)).dx;
      expect(rosterDx, lessThan(gridDx));

      await teardownCallScaffold(tester);
    });
  });

  group('CallActiveScaffold - landscape, ringing focus', () {
    testWidgets('Decline/Answer take the action zones; no separate hangup stands apart', (tester) async {
      setLandscapePhoneSurface(tester);
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [ringing], focusedCall: ringing));

      expect(find.byType(IncomingCallActions), findsOneWidget);
      expect(find.byType(ActiveCallActions), findsNothing);
      // The decline button is the only hangup-keyed control on screen.
      expect(find.byKey(callActionsHangupKey), findsOneWidget);
      expect(
        find.descendant(of: find.byType(IncomingCallActions), matching: find.byKey(callActionsHangupKey)),
        findsOneWidget,
      );

      final infoDx = tester.getCenter(find.byType(CallInfo)).dx;
      final actionsDx = tester.getCenter(find.byType(IncomingCallActions)).dx;
      expect(infoDx, lessThan(actionsDx));

      await teardownCallScaffold(tester);
    });

    testWidgets('with another call around the hint still spells the side effect', (tester) async {
      setLandscapePhoneSurface(tester);
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [active, ringing], focusedCall: ringing));

      expect(find.byType(FocusedActionHint), findsOneWidget);
      expect(find.byType(CallList), findsOneWidget);

      await teardownCallScaffold(tester);
    });
  });

  group('CallActiveScaffold - landscape keypad', () {
    testWidgets('the keypad opens in landscape beside the avatar, and hiding it brings the grid back', (tester) async {
      setLandscapePhoneSurface(tester);
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [active], focusedCall: active));
      expect(find.byType(CallRemoteAvatar), findsOneWidget);

      await tester.tap(find.byKey(callActionsKeypadKey));
      await tester.pumpAndSettle();

      expect(find.byType(KeypadKeyButton), findsNWidgets(12));
      // There is room for both: the avatar stays while the keypad is open.
      expect(find.byType(CallRemoteAvatar), findsOneWidget);

      // The keys stay usable - at least the size the design draws them at.
      // Measured on screen: getRect applies the zone's FittedBox scale, while
      // getSize would report the pre-scale layout size and pass vacuously.
      final keyRect = tester.getRect(find.byType(KeypadKeyButton).first);
      expect(keyRect.width, greaterThanOrEqualTo(56));

      // The way to close the keypad stands in the hangup zone, not in the grid.
      expect(find.byKey(callActionsHideKeypadKey), findsOneWidget);
      expect(
        find.descendant(of: find.byType(ActiveCallActions), matching: find.byKey(callActionsHideKeypadKey)),
        findsNothing,
      );

      await tester.tap(find.byKey(callActionsHideKeypadKey));
      await tester.pumpAndSettle();
      expect(find.byType(KeypadKeyButton), findsNothing);

      await teardownCallScaffold(tester);
    });

    testWidgets('typed digits show up beside the caller, and switching lines closes the keypad', (tester) async {
      setLandscapePhoneSurface(tester);
      final held = makeCall(callId: 'held', acceptedTime: DateTime(2024), held: true, displayName: 'Clara Diaz');
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [active, held], focusedCall: active));

      await tester.tap(find.byKey(callActionsKeypadKey));
      await tester.pumpAndSettle();

      // Nothing typed yet - no stray underlined placeholder in the info zone.
      expect(find.text(' '), findsNothing);

      await tester.tap(find.text('5'));
      await tester.tap(find.text('2'));
      await tester.pump();

      // The landscape keypad has no display of its own - the digits stand in
      // the info zone, with the person they are being sent to.
      expect(find.text('52'), findsOneWidget);

      // Focusing another line closes the keypad: a DTMF session belongs to
      // the call it was opened for.
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [active, held], focusedCall: held));
      await tester.pumpAndSettle();
      expect(find.byType(KeypadKeyButton), findsNothing);
      expect(find.text('52'), findsNothing);

      await teardownCallScaffold(tester);
    });

    testWidgets('a long dial shows its tail, not its head', (tester) async {
      setLandscapePhoneSurface(tester);
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [active], focusedCall: active));
      await tester.tap(find.byKey(callActionsKeypadKey));
      await tester.pumpAndSettle();

      for (var i = 0; i < 22; i++) {
        await tester.tap(find.text('1').first);
      }
      await tester.pump();

      // The newest digits matter most - the display clips the head, the way
      // the portrait field keeps its caret at the end.
      expect(find.text('...${'1' * 18}'), findsOneWidget);

      await teardownCallScaffold(tester);
    });

    testWidgets('the typed digits survive rotation in both directions', (tester) async {
      tester.view.physicalSize = const Size(1206, 2622);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [active], focusedCall: active));
      await tester.tap(find.byKey(callActionsKeypadKey));
      await tester.pumpAndSettle();
      await tester.tap(find.text('5'));
      await tester.pump();

      tester.view.physicalSize = const Size(2622, 1206);
      await tester.pumpAndSettle();
      await tester.tap(find.text('2'));
      await tester.pump();
      expect(find.text('52'), findsOneWidget);

      tester.view.physicalSize = const Size(1206, 2622);
      await tester.pumpAndSettle();
      // One buffer for both orientations: the portrait display carries on
      // with everything typed so far instead of starting blank.
      expect(find.text('52'), findsOneWidget);

      await teardownCallScaffold(tester);
    });

    testWidgets('turning the phone keeps the open keypad open', (tester) async {
      tester.view.physicalSize = const Size(1206, 2622);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [active], focusedCall: active));
      await tester.tap(find.byKey(callActionsKeypadKey));
      await tester.pumpAndSettle();
      expect(find.byType(KeypadKeyButton), findsNWidgets(12));

      tester.view.physicalSize = const Size(2622, 1206);
      await tester.pumpAndSettle();
      expect(find.byType(KeypadKeyButton), findsNWidgets(12));

      tester.view.physicalSize = const Size(1206, 2622);
      await tester.pumpAndSettle();
      expect(find.byType(KeypadKeyButton), findsNWidgets(12));

      await teardownCallScaffold(tester);
    });
  });

  group('CallActiveScaffold - degenerate landscape surfaces', () {
    testWidgets('a split-screen-narrow window lays out without overflowing', (tester) async {
      tester.view.physicalSize = const Size(1095, 900); // 365x300 logical
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [active], focusedCall: active));
      await tester.pump();
      expect(tester.takeException(), isNull);

      // Shrunken, but never below a usable tap target: the isolated hangup is
      // the only way to end the call. Measured on screen (getRect applies the
      // FittedBox scale; getSize would report the pre-scale layout size).
      expect(tester.getRect(find.byKey(callActionsHangupKey)).width, greaterThanOrEqualTo(44));

      // The floor covers the whole grid, not just the hangup: the grid zone
      // stops shrinking at the width where its scaled buttons reach the
      // minimum tap size, and the info zone gives way instead.
      expect(tester.getRect(find.byKey(callActionsMuteKey)).width, greaterThanOrEqualTo(44));

      await teardownCallScaffold(tester);
    });

    testWidgets('a window too narrow for the isolated zone folds the hangup back into the grid', (tester) async {
      tester.view.physicalSize = const Size(900, 600); // 300x200 logical
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [active], focusedCall: active));
      await tester.pump();
      expect(tester.takeException(), isNull);

      // No room for the rule and a zone of its own - but ending the call is
      // never out of reach: the hangup rides the grid's own row again, and
      // it renders at a real size instead of being budgeted away.
      expect(
        find.descendant(of: find.byType(ActiveCallActions), matching: find.byKey(callActionsHangupKey)),
        findsOneWidget,
      );
      expect(tester.getRect(find.byKey(callActionsHangupKey)).width, greaterThan(0));

      await teardownCallScaffold(tester);
    });

    testWidgets('a ringing focus keeps Decline and Answer full-size under a doubled font scale', (tester) async {
      setLandscapePhoneSurface(tester);
      tester.platformDispatcher.textScaleFactorTestValue = 2.0;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

      final chattyActive = makeCall(
        callId: 'active-long',
        acceptedTime: DateTime(2024),
        displayName: 'Boris Klein-Oberhausen von Langenschield',
      );
      final chattyRinging = makeCall(
        callId: 'ringing-long',
        processingStatus: CallProcessingStatus.incomingFromOffer,
        displayName: 'Anna Marchenko-Zvenyhorodska of Support',
      );
      await tester.pumpWidget(
        buildCallScaffold(callBloc, activeCalls: [chattyActive, chattyRinging], focusedCall: chattyRinging),
      );
      await tester.pump();
      expect(tester.takeException(), isNull);

      // The hint wraps and scrolls; it never shares a scale with the two
      // decisions, so raised accessibility text cannot shrink them - they
      // are the most time-critical buttons on screen.
      final answer = find.ancestor(of: find.byIcon(Icons.call), matching: find.byType(TextButton)).first;
      expect(tester.getRect(answer).height, greaterThanOrEqualTo(44));

      await teardownCallScaffold(tester);
    });

    testWidgets('a doubled font scale lays out without overflowing', (tester) async {
      setLandscapePhoneSurface(tester);
      tester.platformDispatcher.textScaleFactorTestValue = 2.0;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [active], focusedCall: active));
      await tester.pump();
      expect(tester.takeException(), isNull);
      await teardownCallScaffold(tester);
    });
  });

  group('CallControlsLandscape - video call info zone', () {
    testWidgets('with a live picture behind, the lines range left instead of floating centered', (tester) async {
      setLandscapePhoneSurface(tester);
      final params = CallControlsParams(
        activeCalls: [active],
        focusedCall: active,
        availableAudioDevices: const [],
        callConfig: const CallCapabilitiesConfig(),
        interactionsEnabled: true,
        // A live video call: the picture fills the screen behind the
        // controls, so the avatar stands down.
        hasRenderableRemoteFrame: true,
        dtmfInput: ValueNotifier(''),
        onCallSelected: (_) {},
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
        onHangup: () {},
        onAccept: () {},
      );
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: CallControlsLandscape(params: params)),
        ),
      );

      expect(find.byType(CallRemoteAvatar), findsNothing);
      // Without the picture beside them the lines still stand where it
      // would have stood - at the start of the zone (behind the 32dp
      // arrangement padding), not floating in the middle of it.
      expect(tester.getTopLeft(find.text('Boris Klein')).dx, moreOrLessEquals(32, epsilon: 1));

      await teardownCallScaffold(tester);
    });
  });

  group('CallActiveScaffold - turning the phone', () {
    testWidgets('portrait keeps the hangup inside the grid; landscape moves it out', (tester) async {
      tester.view.physicalSize = const Size(1206, 2622);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [active], focusedCall: active));
      expect(
        find.descendant(of: find.byType(ActiveCallActions), matching: find.byKey(callActionsHangupKey)),
        findsOneWidget,
      );

      tester.view.physicalSize = const Size(2622, 1206);
      await tester.pumpAndSettle();
      expect(
        find.descendant(of: find.byType(ActiveCallActions), matching: find.byKey(callActionsHangupKey)),
        findsNothing,
      );
      expect(find.byKey(callActionsHangupKey), findsOneWidget);

      await teardownCallScaffold(tester);
    });
  });
}
