import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/messaging/features/conversations/widgets/conversations_new_button.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

import '../../helpers/helpers.dart';

void main() {
  Future<void> pump(WidgetTester tester, ConversationsTab tab, {VoidCallback? onPressed}) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: ConversationsNewButton(tab: tab, onPressed: onPressed ?? () {}),
        ),
      ),
    );
  }

  testWidgets('on the chat tab it offers to start a chat', (tester) async {
    final handle = tester.ensureSemantics();

    await pump(tester, ConversationsTab.chat);

    // The icon is a plus sign: it says nothing on its own, and it means two
    // different things depending on the tab it sits on.
    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(conversationsNewId),
      label: 'Start a new chat',
      identifier: conversationsNewId,
    );

    handle.dispose();
  });

  testWidgets('on the messages tab it offers to write a message', (tester) async {
    final handle = tester.ensureSemantics();

    await pump(tester, ConversationsTab.sms);

    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(conversationsNewId),
      label: 'Write a new message',
      identifier: conversationsNewId,
    );

    handle.dispose();
  });

  testWidgets('a screen reader can activate it, not just a finger', (tester) async {
    final handle = tester.ensureSemantics();
    var pressed = 0;

    await pump(tester, ConversationsTab.chat, onPressed: () => pressed++);
    await tapViaSemantics(tester, find.bySemanticsIdentifier(conversationsNewId));

    expect(pressed, 1);

    handle.dispose();
  });

  testWidgets('the screen it lives on has no unlabelled tap targets left', (tester) async {
    final handle = tester.ensureSemantics();

    await pump(tester, ConversationsTab.chat);

    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

    handle.dispose();
  });
}
