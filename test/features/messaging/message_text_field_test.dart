import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/messaging/widgets/message_list_view/message_text_field.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

void main() {
  Future<TextEditingController> pump(WidgetTester tester, {VoidCallback? onSend}) async {
    final controller = TextEditingController();
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: MessageTextField(controller: controller, onSend: onSend ?? () {}),
        ),
      ),
    );
    return controller;
  }

  // Both sides of the cross-fade stay in the tree; the hidden one is behind an
  // IgnorePointer, so "can it be pressed" is the honest question to ask.
  Finder sendIcon() => find.byIcon(Icons.send).hitTestable();

  // The cross-fade keeps both children mounted while it runs, so a settled
  // frame is what tells whether the send arrow is really offered.
  Future<void> settle(WidgetTester tester) => tester.pumpAndSettle();

  testWidgets('the arrow shows up once there is something to send', (tester) async {
    await pump(tester);
    await settle(tester);

    expect(sendIcon(), findsNothing);

    await tester.enterText(find.byType(TextFormField), 'hello');
    await settle(tester);

    expect(sendIcon(), findsOneWidget);
  });

  testWidgets('the arrow follows text put into the field by the app', (tester) async {
    // Choosing "edit" on a message fills the field from code; nothing is typed,
    // and the arrow used to stay away until the person touched the keyboard.
    final controller = await pump(tester);
    controller.text = 'a message being edited';
    await settle(tester);

    expect(sendIcon(), findsOneWidget);
  });

  testWidgets('the arrow goes away once the message has left', (tester) async {
    // Sending clears the field from code, the same way as above.
    final controller = await pump(tester);
    await tester.enterText(find.byType(TextFormField), 'hello');
    await settle(tester);

    controller.text = '';
    await settle(tester);

    expect(sendIcon(), findsNothing);
  });

  testWidgets('the bar stays the same height when the arrow arrives', (tester) async {
    // The arrow is taller than the field beside it, so without care the whole
    // bar would jump on the first letter typed and drop back on sending.
    final controller = await pump(tester);
    await settle(tester);
    final empty = tester.getSize(find.byType(MessageTextField));

    controller.text = 'hello';
    await settle(tester);

    expect(tester.getSize(find.byType(MessageTextField)), empty);
  });

  testWidgets('the arrow is big enough to hit', (tester) async {
    // The size Android asks for. The field beside it stays as it was: it is
    // 40 high but the width of the bar, so it was never hard to hit.
    final controller = await pump(tester);
    controller.text = 'hello';
    await settle(tester);

    expect(tester.getSize(find.byType(IconButton)), const Size(48, 48));
  });

  testWidgets('spaces alone are not something to send', (tester) async {
    await pump(tester);
    await tester.enterText(find.byType(TextFormField), '   ');
    await settle(tester);

    expect(sendIcon(), findsNothing);
  });
}
