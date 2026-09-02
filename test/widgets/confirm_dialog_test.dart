import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

void main() {
  /// Opens the dialog and hands back what the caller is left holding. The
  /// answer is captured by the button that opened it, so it can only be read
  /// after the dialog is gone - which is the whole point of asserting it.
  Future<Future<bool?> Function()> open(WidgetTester tester, {String? content, bool dangerous = false}) async {
    bool? answer;
    var answered = false;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () async {
                answer = dangerous
                    ? await ConfirmDialog.showDangerous(context, title: 'Leave this group?', content: content)
                    : await ConfirmDialog.show(context, title: 'Leave this group?', content: content);
                answered = true;
              },
              child: const Text('open'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    return () async {
      await tester.pumpAndSettle();
      expect(answered, isTrue, reason: 'the dialog never came back to the caller');
      return answer;
    };
  }

  testWidgets('a question that stands on its own is shown without a second line', (tester) async {
    // The dialog the messaging screens used to carry had a question and nothing
    // else; asking them to repeat it in smaller type below would read worse.
    await open(tester);

    expect(find.text('Leave this group?'), findsOneWidget);
    expect(tester.widget<AlertDialog>(find.byType(AlertDialog)).content, isNull);
  });

  testWidgets('a question that needs saying more keeps its second line', (tester) async {
    await open(tester, content: 'It will be removed from the account.');

    expect(find.text('Leave this group?'), findsOneWidget);
    expect(find.text('It will be removed from the account.'), findsOneWidget);
  });

  testWidgets('yes comes back as yes and no as no', (tester) async {
    // Both buttons pop, so "the dialog closed" says nothing about which of them
    // was pressed - the answer is what the caller acts on.
    for (final (button, expected) in [(confirmDialogYesButtonKey, true), (confirmDialogNoButtonKey, false)]) {
      final answer = await open(tester, dangerous: true);

      await tester.tap(find.byKey(button));

      expect(await answer(), expected);
      expect(find.byType(AlertDialog), findsNothing);
    }
  });

  testWidgets('dismissing it answers nothing at all', (tester) async {
    // Tapping outside is neither yes nor no, and every caller checks for that.
    final answer = await open(tester);

    await tester.tapAt(const Offset(10, 10));

    expect(await answer(), isNull);
  });
}
