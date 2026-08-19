import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/messaging/features/conversations/widgets/unread_badge.dart';
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

  testWidgets('a tab of the app bar strip is big enough to be hit', (tester) async {
    // The strip is sized by the app bar, not by the tab: kMainAppBarBottomTabHeight
    // minus the gap below it is what every tab gets, on all four screens that
    // carry one.
    final controller = TabController(length: 2, vsync: const TestVSync());
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(kMainAppBarBottomTabHeight),
              child: Padding(
                padding: const EdgeInsets.only(bottom: kMainAppBarBottomPaddingGap),
                child: ExtTabBar(
                  controller: controller,
                  height: kMainAppBarBottomTabHeight - kMainAppBarBottomPaddingGap,
                  tabs: const [
                    ExtTab(identifier: contactsTabLocalId, text: 'Phone'),
                    ExtTab(identifier: contactsTabExtId, text: 'Directory'),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(controller: controller, children: const [Text('local'), Text('external')]),
        ),
      ),
    );

    // The node the platform is told about is the merged one that answers the
    // press - the Tab widget itself reports its own preferred height, which
    // is not what a finger has to hit.
    final handle = tester.ensureSemantics();
    final tab = tester.getSemantics(find.bySemanticsIdentifier(contactsTabLocalId));
    expect(tab.rect.height, greaterThanOrEqualTo(kMinInteractiveDimension));
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
                    // The shape the conversations screen builds: caption plus
                    // the badge, which keeps itself out of what is spoken.
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Chats'),
                        const SizedBox(width: 4),
                        UnreadBadge(count: 3, isActive: true, colorScheme: ThemeData().colorScheme),
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

    // The whole spoken name, not a containment check: a caption that drifted
    // onto a node above the press would still "contain" the word.
    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(conversationsTabChatId),
      label: 'Tab 1 of 2\nChats',
      identifier: conversationsTabChatId,
    );
    final chats = tester.getSemantics(find.bySemanticsIdentifier(conversationsTabChatId)).getSemanticsData();
    expect(chats.value, '3 unread conversations', reason: 'the count is state, spoken after the name');

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
