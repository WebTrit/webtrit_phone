import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/messaging/features/conversations/widgets/unread_badge.dart';

void main() {
  testWidgets('the badge draws its number and says nothing', (tester) async {
    // Everywhere it is drawn the badge sits inside a node someone else names,
    // and a raw digit merged into such a node is read out as part of that
    // node's name. The host names the count as state instead - so the badge
    // itself must contribute nothing, whoever draws it.
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Semantics(
            container: true,
            label: 'Chats',
            child: UnreadBadge(count: 3, isActive: false, colorScheme: ThemeData().colorScheme),
          ),
        ),
      ),
    );

    expect(find.text('3'), findsOneWidget, reason: 'the number is still drawn');
    expect(
      tester.getSemantics(find.bySemanticsLabel('Chats')).getSemanticsData().label,
      'Chats',
      reason: 'nothing of the badge reaches what is spoken',
    );

    handle.dispose();
  });
}
