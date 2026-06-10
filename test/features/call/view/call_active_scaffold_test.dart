import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/features/call/view/call_active_scaffold.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/theme.dart';

// ---------------------------------------------------------------------------
// Mocks / helpers
// ---------------------------------------------------------------------------

class _MockCallBloc extends MockBloc<CallEvent, CallState> implements CallBloc {}

const _kHandle = CallkeepHandle.number('+380991234567');

ActiveCall _makeCall({
  String callId = 'call-1',
  CallDirection direction = CallDirection.incoming,
  CallProcessingStatus processingStatus = CallProcessingStatus.connected,
  bool held = false,
  DateTime? acceptedTime,
  String? displayName,
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
  );
}

Widget _buildSubject(_MockCallBloc callBloc, {required List<ActiveCall> activeCalls, required ActiveCall focusedCall}) {
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
      home: BlocProvider<CallBloc>.value(
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
      ),
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
