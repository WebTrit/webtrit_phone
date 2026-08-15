import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/features/call/view/call_active_scaffold.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/keypad_key_button.dart';

import '../../../helpers/helpers.dart';

// ---------------------------------------------------------------------------
// Mocks / helpers
// ---------------------------------------------------------------------------

class _MockCallBloc extends MockBloc<CallEvent, CallState> implements CallBloc {}

class _MockAppPermissions extends Mock implements AppPermissions {}

const _kHandle = CallkeepHandle.number('+380991234567');

ActiveCall _makeCall({
  String callId = 'call-1',
  CallDirection direction = CallDirection.incoming,
  CallProcessingStatus processingStatus = CallProcessingStatus.connected,
  bool held = false,
  DateTime? acceptedTime,
  String? displayName,
  bool videoPermissionDenied = false,
  bool video = false,
}) {
  return ActiveCall(
    callId: callId,
    direction: direction,
    line: 0,
    handle: _kHandle,
    createdTime: DateTime(2024),
    video: video,
    processingStatus: processingStatus,
    held: held,
    acceptedTime: acceptedTime,
    displayName: displayName,
    videoPermissionDenied: videoPermissionDenied,
  );
}

/// A connected two-way video call - the only kind whose controls hide
/// themselves after a few idle seconds.
///
/// Both flags are getters over live media streams, so they are answered here
/// instead of being assembled out of fake tracks.
class _VideoCall extends ActiveCall {
  _VideoCall()
    : super(
        callId: 'video',
        direction: CallDirection.incoming,
        line: 0,
        handle: _kHandle,
        createdTime: DateTime(2024),
        video: true,
        processingStatus: CallProcessingStatus.connected,
        acceptedTime: DateTime(2024),
        displayName: 'Anna Marchenko',
      );

  @override
  bool get isCameraActive => true;

  @override
  bool get remoteVideo => true;
}

/// How visible the block that holds every call control currently is: 1 while it
/// is on screen, 0 once it has hidden itself.
double _controlsOpacity(WidgetTester tester, {Type of = ActiveCallActions}) {
  final opacity = find.ancestor(of: find.byType(of), matching: find.byType(AnimatedOpacity));
  return tester.widget<AnimatedOpacity>(opacity.first).opacity;
}

/// The hangup control stands for the whole block below - they hide and come
/// back together.
final _hangup = find.bySemanticsIdentifier(callActionsHangupId);

/// The controls a screen reader can reach, in the order it would step through
/// them.
///
/// Hiding the block draws it at zero opacity, and that drops the whole subtree
/// out of this list while every widget stays where it was - so a widget finder
/// proves nothing about it, and these tests read the traversal instead.
Iterable<String> _reachableControls(WidgetTester tester) =>
    tester.semantics.simulatedAccessibilityTraversal().map((node) => node.getSemanticsData().identifier);

Widget _buildSubject(
  _MockCallBloc callBloc, {
  required List<ActiveCall> activeCalls,
  required ActiveCall focusedCall,
  AppPermissions? appPermissions,
  bool keepControlsVisible = false,
}) {
  Widget scaffold = BlocProvider<CallBloc>.value(
    value: callBloc,
    child: CallActiveScaffold(
      callStatus: CallStatus.ready,
      activeCalls: activeCalls,
      focusedCall: focusedCall,
      audioDevice: null,
      availableAudioDevices: const [],
      callConfig: const CallCapabilitiesConfig(),
      localePlaceholderBuilder: null,
      remotePlaceholderBuilder: null,
      keepControlsVisible: keepControlsVisible,
    ),
  );
  // Only the camera permission-denied tap reads AppPermissions; provide it on demand.
  if (appPermissions != null) {
    scaffold = Provider<AppPermissions>.value(value: appPermissions, child: scaffold);
  }
  return ThemeProvider(
    settings: const ThemeSettings(),
    lightDynamic: null,
    darkDynamic: null,
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // No router in the harness: hide the AutoRouter-backed back button.
      theme: ThemeData(
        extensions: [CallScreenStyles(primary: CallScreenStyle(appBar: const AppBarStyle(showBackButton: false)))],
      ),
      home: scaffold,
    ),
  );
}

/// Disposes the scaffold (cancelling its periodic probe timer) and flushes the
/// one-shot interaction-debounce timer so the test ends with no pending timers.
Future<void> _teardown(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox());
  await tester.pump(const Duration(seconds: 3));
}

void main() {
  late _MockCallBloc callBloc;

  setUp(() {
    callBloc = _MockCallBloc();
    when(() => callBloc.state).thenReturn(const CallState());
  });

  final ringing = _makeCall(
    callId: 'ringing',
    processingStatus: CallProcessingStatus.incomingFromOffer,
    displayName: 'Anna Marchenko',
  );
  final active = _makeCall(callId: 'active', acceptedTime: DateTime(2024), displayName: 'Boris Klein');

  group('CallActiveScaffold - single call (list of 1)', () {
    testWidgets('1 incoming: Decline/Answer only, no list, no hint', (tester) async {
      await tester.pumpWidget(_buildSubject(callBloc, activeCalls: [ringing], focusedCall: ringing));

      expect(find.byType(IncomingCallActions), findsOneWidget);
      expect(find.byType(ActiveCallActions), findsNothing);
      expect(find.byType(CallList), findsNothing);
      expect(find.byType(FocusedActionHint), findsNothing);
      expect(find.byType(CallInfo), findsOneWidget);
      await _teardown(tester);
    });

    testWidgets('1 active: control grid, no incoming actions, no list', (tester) async {
      await tester.pumpWidget(_buildSubject(callBloc, activeCalls: [active], focusedCall: active));

      expect(find.byType(ActiveCallActions), findsOneWidget);
      expect(find.byType(IncomingCallActions), findsNothing);
      expect(find.byType(CallList), findsNothing);
      await _teardown(tester);
    });

    testWidgets('1 on hold: control grid as well', (tester) async {
      final held = _makeCall(callId: 'held', acceptedTime: DateTime(2024), held: true);
      await tester.pumpWidget(_buildSubject(callBloc, activeCalls: [held], focusedCall: held));

      expect(find.byType(ActiveCallActions), findsOneWidget);
      expect(find.byType(IncomingCallActions), findsNothing);
      await _teardown(tester);
    });
  });

  group('CallActiveScaffold - active + incoming', () {
    testWidgets('ringing focus: list + hint with hold side effect + two buttons', (tester) async {
      await tester.pumpWidget(_buildSubject(callBloc, activeCalls: [active, ringing], focusedCall: ringing));
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
      await _teardown(tester);
    });

    testWidgets('answer dispatches the holding intent for the focused call', (tester) async {
      await tester.pumpWidget(_buildSubject(callBloc, activeCalls: [active, ringing], focusedCall: ringing));

      await tester.tap(find.byIcon(Icons.call));
      verify(() => callBloc.add(const CallControlEvent.answeredHoldingOthers('ringing'))).called(1);
      await _teardown(tester);
    });

    testWidgets('tapping the active row focuses it', (tester) async {
      await tester.pumpWidget(_buildSubject(callBloc, activeCalls: [active, ringing], focusedCall: ringing));

      await tester.tap(find.byKey(const ValueKey('CallRow-active')));
      verify(() => callBloc.add(const CallControlEvent.callSelected('active'))).called(1);
      await _teardown(tester);
    });

    testWidgets('active focus: control grid instead of incoming actions', (tester) async {
      await tester.pumpWidget(_buildSubject(callBloc, activeCalls: [active, ringing], focusedCall: active));

      expect(find.byType(ActiveCallActions), findsOneWidget);
      expect(find.byType(IncomingCallActions), findsNothing);
      expect(find.byType(CallList), findsOneWidget);
      await _teardown(tester);
    });
  });

  group('CallActiveScaffold - hold and resume on the focused call', () {
    testWidgets('Hold on an active focus holds just that call', (tester) async {
      final held = _makeCall(callId: 'held', acceptedTime: DateTime(2024), held: true, displayName: 'Clara Diaz');
      await tester.pumpWidget(_buildSubject(callBloc, activeCalls: [held, active], focusedCall: active));

      await tester.tap(find.byIcon(Icons.pause));
      verify(() => callBloc.add(const CallControlEvent.setHeld('active', true))).called(1);
      await _teardown(tester);
    });

    testWidgets('Resume on a held focus holds the live call and resumes the focused one', (tester) async {
      final held = _makeCall(callId: 'held', acceptedTime: DateTime(2024), held: true, displayName: 'Clara Diaz');
      await tester.pumpWidget(_buildSubject(callBloc, activeCalls: [held, active], focusedCall: held));

      // The slot is a Resume affordance for a held focus - no swap button.
      expect(find.byIcon(Icons.swap_calls), findsNothing);
      await tester.tap(find.byIcon(Icons.play_arrow));
      verify(() => callBloc.add(const CallControlEvent.resumedHoldingOthers('held'))).called(1);
      await _teardown(tester);
    });
  });

  group('CallActiveScaffold - camera permission denied', () {
    testWidgets('camera button shows the permission-denied tooltip', (tester) async {
      final call = _makeCall(callId: 'active', acceptedTime: DateTime(2024), videoPermissionDenied: true);
      await tester.pumpWidget(_buildSubject(callBloc, activeCalls: [call], focusedCall: call));
      final context = tester.element(find.byType(CallActiveScaffold));

      expect(find.byTooltip(context.l10n.call_CallActionsTooltip_cameraPermissionDenied), findsOneWidget);
      expect(find.byTooltip(context.l10n.call_CallActionsTooltip_enableCamera), findsNothing);
      await _teardown(tester);
    });

    testWidgets('tap enables the camera when permission is now granted', (tester) async {
      final appPermissions = _MockAppPermissions();
      when(() => appPermissions.isPermissionGranted(Permission.camera)).thenAnswer((_) async => true);
      final call = _makeCall(callId: 'active', acceptedTime: DateTime(2024), videoPermissionDenied: true);
      await tester.pumpWidget(
        _buildSubject(callBloc, activeCalls: [call], focusedCall: call, appPermissions: appPermissions),
      );

      await tester.tap(find.byIcon(Icons.videocam_off));
      await tester.pump();

      verify(() => callBloc.add(const CallControlEvent.cameraEnabled('active', true))).called(1);
      verifyNever(() => appPermissions.toAppSettings());
      await _teardown(tester);
    });

    testWidgets('tap opens app settings when permission is still denied', (tester) async {
      final appPermissions = _MockAppPermissions();
      when(() => appPermissions.isPermissionGranted(Permission.camera)).thenAnswer((_) async => false);
      when(() => appPermissions.toAppSettings()).thenAnswer((_) async {});
      final call = _makeCall(callId: 'active', acceptedTime: DateTime(2024), videoPermissionDenied: true);
      await tester.pumpWidget(
        _buildSubject(callBloc, activeCalls: [call], focusedCall: call, appPermissions: appPermissions),
      );

      await tester.tap(find.byIcon(Icons.videocam_off));
      await tester.pump();

      verify(() => appPermissions.toAppSettings()).called(1);
      await _teardown(tester);
    });
  });

  group('CallActiveScaffold - attended transfer submit', () {
    final original = _makeCall(callId: 'original', acceptedTime: DateTime(2024), held: true, displayName: 'Clara Diaz');
    final consultation = _makeCall(
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
        await tester.pumpWidget(_buildSubject(callBloc, activeCalls: [original, consultation], focusedCall: focused));

        await openTransferMenu(tester);
        await tester.tap(find.byKey(callActionsTransferMenuNumberKey));
        await tester.pumpAndSettle();

        verify(
          () => callBloc.add(
            CallControlEvent.attendedTransferSubmitted(referorCall: original, replaceCall: consultation),
          ),
        ).called(1);
        await _teardown(tester);
      });
    }

    testWidgets('attended item is absent while the consultation call is not yet accepted', (tester) async {
      final ringingConsultation = _makeCall(
        callId: 'consultation',
        direction: CallDirection.outgoing,
        displayName: 'Boris Klein',
      );
      await tester.pumpWidget(
        _buildSubject(callBloc, activeCalls: [original, ringingConsultation], focusedCall: original),
      );

      await openTransferMenu(tester);

      expect(find.byKey(callActionsTransferMenuNumberKey), findsNothing);
      await _teardown(tester);
    });
  });

  group('CallActiveScaffold - avatar in the video area', () {
    testWidgets('audio-only call shows the remote avatar instead of the video overlay', (tester) async {
      await tester.pumpWidget(_buildSubject(callBloc, activeCalls: [active], focusedCall: active));

      expect(find.byType(CallRemoteAvatar), findsOneWidget);
      expect(find.byType(RemoteVideoViewOverlay), findsNothing);
      await _teardown(tester);
    });

    testWidgets('falls back to the initials of the remote display name', (tester) async {
      await tester.pumpWidget(_buildSubject(callBloc, activeCalls: [active], focusedCall: active));
      await tester.pump();

      expect(find.descendant(of: find.byType(CallRemoteAvatar), matching: find.text('BK')), findsOneWidget);
      await _teardown(tester);
    });

    testWidgets('the open in-call keypad hides the avatar and keeps the keys full size', (tester) async {
      // The in-call keypad opens only in portrait orientation.
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(_buildSubject(callBloc, activeCalls: [active], focusedCall: active));
      expect(find.byType(CallRemoteAvatar), findsOneWidget);

      await tester.tap(find.byKey(callActionsKeypadKey));
      await tester.pumpAndSettle();

      // The avatar makes way for the keypad, and the keys render at their
      // natural size (screen shortest side / 5) - never scaled down.
      expect(find.byType(CallRemoteAvatar), findsNothing);
      final keySize = tester.getSize(find.byType(KeypadKeyButton).first);
      expect(keySize.width, greaterThanOrEqualTo(360 / 5));

      await tester.tap(find.byTooltip('Hide keypad'));
      await tester.pumpAndSettle();
      expect(find.byType(KeypadKeyButton), findsNothing);
      expect(find.byType(CallRemoteAvatar), findsOneWidget);

      await _teardown(tester);
    });
  });

  group('CallActiveScaffold - 3 calls (held + active + incoming)', () {
    testWidgets('three rows, ringing focus keeps two buttons and the hint', (tester) async {
      final held = _makeCall(callId: 'held', acceptedTime: DateTime(2024), held: true, displayName: 'Clara Diaz');
      await tester.pumpWidget(_buildSubject(callBloc, activeCalls: [held, active, ringing], focusedCall: ringing));
      final context = tester.element(find.byType(CallActiveScaffold));

      expect(find.byType(CallRow), findsNWidgets(3));
      expect(find.byType(IncomingCallActions), findsOneWidget);
      // Only the still-active call is named in the hold side effect; the
      // already-held one does not change state.
      expect(
        find.text(context.l10n.call_FocusedActionHint_willBeHeld('Boris Klein'), findRichText: true),
        findsOneWidget,
      );
      await _teardown(tester);
    });
  });

  group('CallActiveScaffold - hiding the controls in a video call', () {
    // The block is dropped from the accessibility tree the moment it is hidden,
    // which is why a caller can demand that it stays - `CallScreen` does so
    // while a screen reader is in use, see ScreenReaderBuilder.
    const idleDelay = Duration(seconds: 8);

    testWidgets('on their own they hide once the call is left alone', (tester) async {
      final semantics = tester.ensureSemantics();
      final call = _VideoCall();
      await tester.pumpWidget(_buildSubject(callBloc, activeCalls: [call], focusedCall: call));

      expect(_controlsOpacity(tester), 1);
      expect(_reachableControls(tester), contains(callActionsHangupId));

      await tester.pump(idleDelay);
      // The block fades out rather than blinks, and it leaves the accessibility
      // tree only once it is fully transparent.
      await tester.pump(kThemeAnimationDuration);
      expect(_controlsOpacity(tester), 0);
      expect(
        _reachableControls(tester),
        isNot(contains(callActionsHangupId)),
        reason: 'hidden controls leave the accessibility tree, so there is no way left to end the call',
      );
      await _teardown(tester);
      semantics.dispose();
    });

    testWidgets('a demand to keep them survives the same wait', (tester) async {
      final semantics = tester.ensureSemantics();
      final call = _VideoCall();
      await tester.pumpWidget(
        _buildSubject(callBloc, activeCalls: [call], focusedCall: call, keepControlsVisible: true),
      );

      await tester.pump(idleDelay);
      expect(_controlsOpacity(tester), 1);
      expect(_reachableControls(tester), contains(callActionsHangupId));
      expectTapTargetSemantics(tester, _hangup, label: 'Hangup', identifier: callActionsHangupId);

      // Reachable is not the same as working: activate it the way assistive
      // technology does and see the call actually end.
      await tapViaSemantics(tester, _hangup);
      verify(() => callBloc.add(const CallControlEvent.ended('video'))).called(1);
      await _teardown(tester);
      semantics.dispose();
    });

    testWidgets('a tap on the picture cannot hide them while they are required to stay', (tester) async {
      final semantics = tester.ensureSemantics();
      final call = _VideoCall();
      await tester.pumpWidget(
        _buildSubject(callBloc, activeCalls: [call], focusedCall: call, keepControlsVisible: true),
      );

      await tester.tapAt(const Offset(20, 400));
      await tester.pump(kThemeAnimationDuration);
      expect(_controlsOpacity(tester), 1);
      expect(_reachableControls(tester), contains(callActionsHangupId));
      await _teardown(tester);
      semantics.dispose();
    });

    testWidgets('a tap anywhere shows and hides them again', (tester) async {
      final call = _VideoCall();
      await tester.pumpWidget(_buildSubject(callBloc, activeCalls: [call], focusedCall: call));

      await tester.tapAt(const Offset(20, 400));
      await tester.pump(kThemeAnimationDuration);
      expect(_controlsOpacity(tester), 0);

      await tester.tapAt(const Offset(20, 400));
      await tester.pump(kThemeAnimationDuration);
      expect(_controlsOpacity(tester), 1);
      await _teardown(tester);
    });

    testWidgets('the tap works the same with no video to tap on', (tester) async {
      // An audio call has no video layer at all, and a ringing one is not even
      // connected - the tap still belongs to the whole screen.
      await tester.pumpWidget(_buildSubject(callBloc, activeCalls: [ringing], focusedCall: ringing));

      await tester.tapAt(const Offset(20, 400));
      await tester.pump(kThemeAnimationDuration);
      expect(_controlsOpacity(tester, of: IncomingCallActions), 0);
      await _teardown(tester);
    });

    testWidgets('the bare toolbar counts as anywhere too', (tester) async {
      // The toolbar carries the status line and nothing else to press, so a tap
      // on it belongs to the same gesture as a tap on the picture.
      final call = _VideoCall();
      await tester.pumpWidget(_buildSubject(callBloc, activeCalls: [call], focusedCall: call));

      await tester.tapAt(tester.getCenter(find.byType(AppBar)));
      await tester.pump(kThemeAnimationDuration);
      expect(_controlsOpacity(tester), 0);
      await _teardown(tester);
    });

    testWidgets('the demand arriving over hidden controls brings them back', (tester) async {
      final call = _VideoCall();
      await tester.pumpWidget(_buildSubject(callBloc, activeCalls: [call], focusedCall: call));
      await tester.pump(idleDelay);
      expect(_controlsOpacity(tester), 0);

      await tester.pumpWidget(
        _buildSubject(callBloc, activeCalls: [call], focusedCall: call, keepControlsVisible: true),
      );
      await tester.pump(kThemeAnimationDuration);
      expect(_controlsOpacity(tester), 1);
      await _teardown(tester);
    });
  });
}
