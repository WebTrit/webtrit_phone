import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../helpers/helpers.dart';

void main() {
  Widget wrap({required TabController controller}) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(36),
            child: ExtTabBar(
              controller: controller,
              height: 36,
              tabs: const [
                ExtTab(identifier: contactsTabLocalId, text: 'Phone'),
                ExtTab(identifier: contactsTabExtId, text: 'Directory'),
              ],
            ),
          ),
        ),
        body: TabBarView(controller: controller, children: const [Text('local'), Text('external')]),
      ),
    );
  }

  testWidgets('each tab carries its id on the node that says its name and answers the press', (tester) async {
    final handle = tester.ensureSemantics();
    final controller = TabController(length: 2, vsync: const TestVSync());
    addTearDown(controller.dispose);

    await tester.pumpWidget(wrap(controller: controller));

    // The captions are translated and the two tabs sit on the same screen, so
    // a flow can only address them by id - and the id is of no use unless it
    // lands on the node that can actually be pressed.
    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(contactsTabLocalId),
      label: 'Tab 1 of 2\nPhone',
      identifier: contactsTabLocalId,
    );
    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(contactsTabExtId),
      label: 'Tab 2 of 2\nDirectory',
      identifier: contactsTabExtId,
    );

    handle.dispose();
  });

  testWidgets('pressing a tab through semantics switches to it', (tester) async {
    final handle = tester.ensureSemantics();
    final controller = TabController(length: 2, vsync: const TestVSync());
    addTearDown(controller.dispose);

    await tester.pumpWidget(wrap(controller: controller));

    await tapViaSemantics(tester, find.bySemanticsIdentifier(contactsTabExtId));
    await tester.pumpAndSettle();

    expect(controller.index, 1);

    handle.dispose();
  });

  testWidgets('a tab that draws a badge keeps the count out of its name', (tester) async {
    // The conversations tabs put an unread badge beside the caption. Inside
    // the merged tab node a raw glyph is read out as part of the name, so it
    // is excluded and what it stood for is spoken as the tab's state.
    final handle = tester.ensureSemantics();
    final controller = TabController(length: 2, vsync: const TestVSync());
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(36),
              child: ExtTabBar(
                controller: controller,
                height: 36,
                tabs: [
                  ExtTab.child(
                    identifier: conversationsTabChatId,
                    value: '3 unread conversations',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Chats'),
                        SizedBox(width: 4),
                        ExcludeSemantics(child: Text('3')),
                      ],
                    ),
                  ),
                  const ExtTab(identifier: conversationsTabSmsId, text: 'Messages'),
                ],
              ),
            ),
          ),
          body: TabBarView(controller: controller, children: const [Text('chats'), Text('sms')]),
        ),
      ),
    );

    final chats = tester.getSemantics(find.bySemanticsIdentifier(conversationsTabChatId)).getSemanticsData();
    expect(chats.label, isNot(contains('3')), reason: 'the digit is a glyph, not part of the name');
    expect(chats.label, contains('Chats'));
    expect(chats.value, '3 unread conversations');
    // Still one addressable, pressable node - the badge did not split it.
    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(conversationsTabChatId),
      identifier: conversationsTabChatId,
    );

    handle.dispose();
  });

  testWidgets('the tab bar leaves no unnamed press target behind', (tester) async {
    final handle = tester.ensureSemantics();
    final controller = TabController(length: 2, vsync: const TestVSync());
    addTearDown(controller.dispose);

    await tester.pumpWidget(wrap(controller: controller));

    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

    handle.dispose();
  });
}
