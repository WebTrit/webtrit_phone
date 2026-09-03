import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';

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

  final active = makeCall(callId: 'active', acceptedTime: DateTime(2024), displayName: 'Boris Klein');
  final held = makeCall(callId: 'held', acceptedTime: DateTime(2024), held: true, displayName: 'Clara Diaz');

  testWidgets('a single call gets the central info block', (tester) async {
    await tester.pumpWidget(wrap(CallInfoBlock(activeCalls: [active], focusedCall: active, onCallSelected: (_) {})));

    expect(find.byType(CallInfo), findsOneWidget);
    expect(find.byType(CallList), findsNothing);
    expect(find.text('Boris Klein'), findsOneWidget);
    expect(find.text(kHandle.value), findsOneWidget);
  });

  testWidgets('several calls get the roster instead, and a row tap reports its call', (tester) async {
    final selected = <String>[];
    await tester.pumpWidget(
      wrap(CallInfoBlock(activeCalls: [active, held], focusedCall: active, onCallSelected: selected.add)),
    );

    expect(find.byType(CallList), findsOneWidget);
    expect(find.byType(CallRow), findsNWidgets(2));
    expect(find.byType(CallInfo), findsNothing);

    await tester.tap(find.byKey(const ValueKey('CallRow-held')));
    expect(selected, ['held']);
  });
}
