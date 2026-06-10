import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

const _kHandle = CallkeepHandle.number('+380991234567');

ActiveCall _makeCall({
  String callId = 'call-1',
  CallDirection direction = CallDirection.incoming,
  CallProcessingStatus processingStatus = CallProcessingStatus.connected,
  bool held = false,
  DateTime? acceptedTime,
  CallkeepHandle handle = _kHandle,
  String? displayName,
}) {
  return ActiveCall(
    callId: callId,
    direction: direction,
    line: 0,
    handle: handle,
    createdTime: DateTime(2024),
    video: false,
    processingStatus: processingStatus,
    held: held,
    acceptedTime: acceptedTime,
    displayName: displayName,
  );
}

Widget _buildSubject({
  required List<ActiveCall> calls,
  required String focusedCallId,
  required ValueChanged<String> onCallTap,
}) {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      body: CallList(calls: calls, focusedCallId: focusedCallId, onCallTap: onCallTap),
    ),
  );
}

void main() {
  final ringing = _makeCall(
    callId: 'ringing',
    processingStatus: CallProcessingStatus.incomingFromOffer,
    displayName: 'Anna Marchenko',
  );
  // Accepted moments ago so the elapsed-time label stays in MM:SS form.
  final onCall = _makeCall(
    callId: 'on-call',
    acceptedTime: DateTime.now().subtract(const Duration(seconds: 65)),
    displayName: 'Boris Klein',
  );
  final held = _makeCall(
    callId: 'held',
    acceptedTime: DateTime.now().subtract(const Duration(seconds: 65)),
    held: true,
    displayName: 'Clara Diaz',
  );

  group('CallList', () {
    testWidgets('renders one row per call with its display name', (tester) async {
      await tester.pumpWidget(
        _buildSubject(calls: [ringing, onCall, held], focusedCallId: 'ringing', onCallTap: (_) {}),
      );

      expect(find.byType(CallRow), findsNWidgets(3));
      expect(find.text('Anna Marchenko'), findsOneWidget);
      expect(find.text('Boris Klein'), findsOneWidget);
      expect(find.text('Clara Diaz'), findsOneWidget);
    });

    testWidgets('falls back to the handle when there is no display name', (tester) async {
      final anonymous = _makeCall(callId: 'anon', processingStatus: CallProcessingStatus.incomingFromOffer);
      await tester.pumpWidget(_buildSubject(calls: [anonymous, onCall], focusedCallId: 'anon', onCallTap: (_) {}));
      expect(find.text(_kHandle.value), findsOneWidget);
    });

    testWidgets('shows the status badge matching each call state', (tester) async {
      await tester.pumpWidget(
        _buildSubject(calls: [ringing, onCall, held], focusedCallId: 'ringing', onCallTap: (_) {}),
      );
      final context = tester.element(find.byType(CallList));

      expect(find.text(context.l10n.callProcessingStatus_ringing.toUpperCase()), findsOneWidget);
      expect(find.text(context.l10n.call_CallList_statusOnCall.toUpperCase()), findsOneWidget);
      expect(find.text(context.l10n.call_description_held.toUpperCase()), findsOneWidget);
    });

    testWidgets('shows the header only when more than one call is present', (tester) async {
      await tester.pumpWidget(_buildSubject(calls: [ringing], focusedCallId: 'ringing', onCallTap: (_) {}));
      final context = tester.element(find.byType(CallList));
      final header = context.l10n.call_CallList_header(1).toUpperCase();
      expect(find.text(header), findsNothing);

      await tester.pumpWidget(_buildSubject(calls: [ringing, onCall], focusedCallId: 'ringing', onCallTap: (_) {}));
      final multiHeader = context.l10n.call_CallList_header(2).toUpperCase();
      expect(find.text(multiHeader), findsOneWidget);
    });

    testWidgets('tapping a row reports its call id', (tester) async {
      final tapped = <String>[];
      await tester.pumpWidget(_buildSubject(calls: [ringing, onCall], focusedCallId: 'ringing', onCallTap: tapped.add));

      await tester.tap(find.byKey(const ValueKey('CallRow-on-call')));
      expect(tapped, ['on-call']);
    });

    testWidgets('highlights only the focused row', (tester) async {
      await tester.pumpWidget(_buildSubject(calls: [ringing, onCall], focusedCallId: 'on-call', onCallTap: (_) {}));

      CallRow rowOf(String callId) => tester.widget<CallRow>(find.byKey(ValueKey('CallRow-$callId')));
      expect(rowOf('on-call').focused, isTrue);
      expect(rowOf('ringing').focused, isFalse);
    });

    testWidgets('shows a ticking duration for an answered call and the direction while ringing', (tester) async {
      // The answered call shows an elapsed-time label (MM:SS); the ringing
      // incoming call shows the direction instead.
      await tester.pumpWidget(_buildSubject(calls: [ringing, onCall], focusedCallId: 'ringing', onCallTap: (_) {}));
      final context = tester.element(find.byType(CallList));

      expect(find.text(context.l10n.call_description_incoming), findsOneWidget);
      expect(find.textContaining(RegExp(r'^\d{2}:\d{2}')), findsOneWidget);

      // Let the periodic ticker fire once, then dispose cleanly.
      await tester.pump(const Duration(seconds: 1));
      expect(find.textContaining(RegExp(r'^\d{2}:\d{2}')), findsOneWidget);
      await tester.pumpWidget(const SizedBox());
    });
  });
}
