import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/contacts/widgets/cleared_text_field.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';

void main() {
  Widget wrap({String? identifier, String? clearIdentifier, String? initialValue}) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // The field draws its clear button through the search decoration the
      // theme supplies; without it there is no suffix to look at.
      theme: ThemeData(
        extensions: const [InputDecorations(search: InputDecoration(), keypad: InputDecoration())],
      ),
      home: Scaffold(
        body: ClearedTextField(
          identifier: identifier,
          clearButtonIdentifier: clearIdentifier,
          initialValue: initialValue,
        ),
      ),
    );
  }

  testWidgets('the search box can be found by the id the screen gives it', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(wrap(identifier: contactsSearchInputId));

    expect(find.bySemanticsIdentifier(contactsSearchInputId), findsOneWidget);
    // Typing must still reach the field: an id must not turn it into one
    // opaque control.
    expect(
      tester.getSemantics(find.bySemanticsIdentifier(contactsSearchInputId)),
      matchesSemantics(
        identifier: contactsSearchInputId,
        isTextField: true,
        hasEnabledState: true,
        isEnabled: true,
        isFocusable: true,
        hasTapAction: true,
        hasFocusAction: true,
      ),
    );

    handle.dispose();
  });

  testWidgets('the clear button keeps an id of its own next to the field', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(
      wrap(identifier: contactsSearchInputId, clearIdentifier: contactsSearchInputClearId, initialValue: '555'),
    );

    expect(find.bySemanticsIdentifier(contactsSearchInputClearId), findsOneWidget);

    handle.dispose();
  });

  testWidgets('a screen that gives no id gets a plain field', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(wrap());

    expect(find.bySemanticsIdentifier(contactsSearchInputId), findsNothing);
    expect(find.byType(TextField), findsOneWidget);

    handle.dispose();
  });
}
