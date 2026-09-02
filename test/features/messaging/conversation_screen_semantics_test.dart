import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/messaging/features/chat_conversation/view/conversation_screen.dart';
import 'package:webtrit_phone/features/messaging/features/chat_conversation/widgets/dialog_info.dart';
import 'package:webtrit_phone/features/messaging/features/sms_conversation/view/sms_conversation_screen.dart';

import '../../helpers/helpers.dart';
import 'conversation_screen_harness.dart';

void main() {
  late ConversationScreenHarness harness;

  // Every state of these screens spins something - a progress indicator while
  // the conversation loads - so settling has to be given a length rather than
  // waited out.
  Future<void> settle(WidgetTester tester) async {
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
  }

  setUp(() => harness = ConversationScreenHarness());

  group('a chat', () {
    testWidgets('names the menu and opens the details from it', (tester) async {
      final handle = tester.ensureSemantics();
      harness.withDialogLoading();

      await tester.pumpWidget(harness.wrap(const ChatConversationScreen()));

      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(conversationMenuId),
        label: 'Conversation details',
        identifier: conversationMenuId,
      );
      await tapViaSemantics(tester, find.bySemanticsIdentifier(conversationMenuId));
      await settle(tester);

      expect(find.byType(DialogChatInfo), findsOneWidget);

      handle.dispose();
    });

    testWidgets('keeps the name while the menu has nothing to open', (tester) async {
      final handle = tester.ensureSemantics();
      harness.withUnknownConversationLoading();

      await tester.pumpWidget(harness.wrap(const ChatConversationScreen()));

      // A conversation that has not loaded is not known to be a group yet, so
      // there is nothing behind the menu - it says what it is and says it is
      // out of use, rather than doing nothing when pressed.
      expect(
        tester.getSemantics(find.bySemanticsIdentifier(conversationMenuId)),
        isSemantics(label: 'Conversation details', identifier: conversationMenuId, isButton: true, isEnabled: false),
      );

      handle.dispose();
    });

    testWidgets('can be told apart from any other screen', (tester) async {
      final handle = tester.ensureSemantics();
      harness.withDialogLoading();

      await tester.pumpWidget(harness.wrap(const ChatConversationScreen()));

      expect(find.bySemanticsIdentifier(chatConversationScreenId), findsOneWidget);

      handle.dispose();
    });

    testWidgets('leaves nothing on it unnamed', (tester) async {
      final handle = tester.ensureSemantics();
      harness.withDialogLoading();

      await tester.pumpWidget(harness.wrap(const ChatConversationScreen()));

      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

      handle.dispose();
    });
  });

  group('a text conversation', () {
    testWidgets('names the menu and opens it', (tester) async {
      final handle = tester.ensureSemantics();
      harness.withSmsConversation();

      await tester.pumpWidget(harness.wrap(const SmsConversationScreen()));
      await settle(tester);

      // The tooltip is asserted empty by this helper: a menu button brings its
      // own "Show menu" one, which is spoken on top of the name.
      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(conversationMenuId),
        label: 'Conversation options',
        identifier: conversationMenuId,
      );
      await tapViaSemantics(tester, find.bySemanticsIdentifier(conversationMenuId));
      await settle(tester);

      expect(find.text('Delete dialog'), findsOneWidget);

      handle.dispose();
    });

    testWidgets('can be told apart from a chat', (tester) async {
      final handle = tester.ensureSemantics();
      harness.withSmsConversation();

      await tester.pumpWidget(harness.wrap(const SmsConversationScreen()));
      await settle(tester);

      expect(find.bySemanticsIdentifier(smsConversationScreenId), findsOneWidget);
      expect(find.bySemanticsIdentifier(chatConversationScreenId), findsNothing);

      handle.dispose();
    });

    testWidgets('leaves nothing on it unnamed', (tester) async {
      final handle = tester.ensureSemantics();
      harness.withSmsConversation();

      await tester.pumpWidget(harness.wrap(const SmsConversationScreen()));
      await settle(tester);

      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

      handle.dispose();
    });
  });
}
