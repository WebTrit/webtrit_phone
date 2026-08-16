import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/messaging/widgets/message_list_view/exchange_bar.dart';
import 'package:webtrit_phone/features/messaging/widgets/message_list_view/message_text_field.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

import '../../helpers/helpers.dart';

void main() {
  Future<Widget> wrap(Widget child) async => MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      body: Align(alignment: Alignment.bottomCenter, child: child),
    ),
  );

  Future<TextEditingController> pumpField(WidgetTester tester, {VoidCallback? onSend}) async {
    final controller = TextEditingController();
    await tester.pumpWidget(await wrap(MessageTextField(controller: controller, onSend: onSend ?? () {})));
    return controller;
  }

  Future<void> pumpBar(
    WidgetTester tester,
    ExchangeKind kind, {
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
  }) async {
    await tester.pumpWidget(
      await wrap(
        ExchangeBar(kind: kind, text: 'the quoted message', onCancel: onCancel ?? () {}, onConfirm: onConfirm),
      ),
    );
  }

  group('the message field', () {
    testWidgets('keeps a name of its own once the hint is gone', (tester) async {
      final handle = tester.ensureSemantics();

      await pumpField(tester);
      await tester.enterText(find.byType(TextFormField), 'hello');
      await tester.pumpAndSettle();

      expect(
        tester.getSemantics(find.bySemanticsIdentifier(messageInputId)),
        isSemantics(label: 'Message', identifier: messageInputId, value: 'hello', isTextField: true),
      );

      handle.dispose();
    });

    testWidgets('the send arrow is a named button a screen reader can press', (tester) async {
      final handle = tester.ensureSemantics();
      var sent = 0;

      final controller = await pumpField(tester, onSend: () => sent++);
      controller.text = 'hello';
      await tester.pumpAndSettle();

      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(messageSendId),
        label: 'Send',
        identifier: messageSendId,
      );
      await tapViaSemantics(tester, find.bySemanticsIdentifier(messageSendId));

      expect(sent, 1);

      handle.dispose();
    });

    testWidgets('the arrow is not offered while there is nothing to send', (tester) async {
      final handle = tester.ensureSemantics();

      await pumpField(tester);
      await tester.pumpAndSettle();

      // The hidden half of the cross-fade stays in the tree; what matters is
      // that a screen reader is never taken to it.
      expect(
        tester.semantics.simulatedAccessibilityTraversal().map((node) => node.getSemanticsData().identifier),
        isNot(contains(messageSendId)),
      );

      handle.dispose();
    });

    testWidgets('nothing on it is left unnamed', (tester) async {
      final handle = tester.ensureSemantics();

      final controller = await pumpField(tester);
      controller.text = 'hello';
      await tester.pumpAndSettle();

      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

      handle.dispose();
    });
  });

  group('the bar above the field', () {
    testWidgets('says which of the three things is happening', (tester) async {
      final handle = tester.ensureSemantics();

      for (final (kind, label, identifier) in [
        (ExchangeKind.reply, 'Replying to', messageReplyBarId),
        (ExchangeKind.edit, 'Editing', messageEditBarId),
        (ExchangeKind.forward, 'Forwarding', messageForwardBarId),
      ]) {
        await pumpBar(tester, kind);

        // The name and the quoted message arrive as one stop: on the screen
        // the three are told apart by a small icon and nothing else.
        expect(
          tester.getSemantics(find.bySemanticsIdentifier(identifier)),
          isSemantics(label: '$label\nthe quoted message', identifier: identifier),
        );
      }

      handle.dispose();
    });

    testWidgets('the cross says what it stops', (tester) async {
      final handle = tester.ensureSemantics();
      var cancelled = 0;

      await pumpBar(tester, ExchangeKind.edit, onCancel: () => cancelled++);

      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(messageExchangeCancelId),
        label: 'Stop editing',
        identifier: messageExchangeCancelId,
      );
      await tapViaSemantics(tester, find.bySemanticsIdentifier(messageExchangeCancelId));

      expect(cancelled, 1);

      handle.dispose();
    });

    testWidgets('the tick is only there when a message is being passed on', (tester) async {
      final handle = tester.ensureSemantics();
      var confirmed = 0;

      await pumpBar(tester, ExchangeKind.reply);
      expect(find.bySemanticsIdentifier(messageExchangeConfirmId), findsNothing);

      await pumpBar(tester, ExchangeKind.forward, onConfirm: () => confirmed++);
      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(messageExchangeConfirmId),
        label: 'Forward the message',
        identifier: messageExchangeConfirmId,
      );
      await tapViaSemantics(tester, find.bySemanticsIdentifier(messageExchangeConfirmId));

      expect(confirmed, 1);

      handle.dispose();
    });

    testWidgets('leaves three stops behind and no more', (tester) async {
      final handle = tester.ensureSemantics();

      await pumpBar(tester, ExchangeKind.forward, onConfirm: () {});

      // The quoted message, the tick, the cross - in that order. The icon in
      // front says nothing of its own and must not become a fourth.
      expect(tester.semantics.simulatedAccessibilityTraversal().map((node) => node.getSemanticsData().label), [
        'Forwarding\nthe quoted message',
        'Forward the message',
        'Stop forwarding',
      ]);
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

      handle.dispose();
    });
  });
}
