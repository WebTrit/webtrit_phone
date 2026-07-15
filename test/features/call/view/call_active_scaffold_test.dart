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
  String? consultationForCallId,
}) {
  return ActiveCall(
    callId: callId,
    direction: direction,
    line: 0,
    handle: _kHandle,
    createdTime: DateTime(2024),
    video: false,
    processingStatus: processingStatus,
    held: held,
    acceptedTime: acceptedTime,
    displayName: displayName,
    videoPermissionDenied: videoPermissionDenied,
    consultationForCallId: consultationForCallId,
  );
}

Widget _buildSubject(
  _MockCallBloc callBloc, {
  required List<ActiveCall> activeCalls,
  required ActiveCall focusedCall,
  AppPermissions? appPermissions,
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
      consultationForCallId: 'original',
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
        consultationForCallId: 'original',
      );
      await tester.pumpWidget(
        _buildSubject(callBloc, activeCalls: [original, ringingConsultation], focusedCall: original),
      );

      await openTransferMenu(tester);

      expect(find.byKey(callActionsTransferMenuNumberKey), findsNothing);
      await _teardown(tester);
    });

    testWidgets('an unrelated third call is never offered or used as the replace target', (tester) async {
      // A third, unrelated call answered mid-transfer becomes `current` (the
      // only non-held call) and auto-holds the consultation call - so neither
      // the focused call nor `current` can be trusted to identify the real
      // consultation call. Only the explicit consultationForCallId link can.
      final thirdParty = _makeCall(callId: 'third-party', acceptedTime: DateTime(2024), displayName: 'Dario Rossi');
      final heldConsultation = consultation.copyWith(held: true);
      await tester.pumpWidget(
        _buildSubject(callBloc, activeCalls: [original, heldConsultation, thirdParty], focusedCall: original),
      );

      await openTransferMenu(tester);
      // Only `original` has a live pairing (with heldConsultation) - the
      // unrelated thirdParty call must not appear as a transfer candidate.
      expect(find.byKey(callActionsTransferMenuNumberKey), findsOneWidget);

      await tester.tap(find.byKey(callActionsTransferMenuNumberKey));
      await tester.pumpAndSettle();

      verify(
        () => callBloc.add(
          CallControlEvent.attendedTransferSubmitted(referorCall: original, replaceCall: heldConsultation),
        ),
      ).called(1);
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
}
