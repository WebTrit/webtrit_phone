import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/contacts/widgets/cleared_text_field.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';

void main() {
  Widget wrap({ValueChanged<String>? onSubmitted, ValueChanged<String>? onChanged}) {
    return MaterialApp(
      // The field names its clear button from the translations, so the
      // delegates have to be here even where the test itself reads no text.
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        extensions: const [InputDecorations(search: InputDecoration(), keypad: InputDecoration())],
      ),
      home: Scaffold(
        body: ClearedTextField(onSubmitted: onSubmitted, onChanged: onChanged),
      ),
    );
  }

  testWidgets('submitting the search reaches the screen', (tester) async {
    final submitted = <String>[];

    await tester.pumpWidget(wrap(onSubmitted: submitted.add));

    await tester.enterText(find.byType(TextField), '555');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump();

    // The callback used to be returned instead of called, so pressing search
    // on the keyboard did nothing at all.
    expect(submitted, ['555']);
  });

  testWidgets('the clear button empties the field and reports it', (tester) async {
    final changed = <String>[];

    await tester.pumpWidget(wrap(onChanged: changed.add));

    await tester.enterText(find.byType(TextField), '555');
    await tester.pump();

    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();

    expect(changed.last, '');
    expect(find.byIcon(Icons.close), findsNothing);
  });
}
