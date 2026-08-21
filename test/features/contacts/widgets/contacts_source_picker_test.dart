import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/contacts/widgets/contacts_source_picker.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

void main() {
  Future<List<ContactSourceType>> pumpPicker(WidgetTester tester, {required ContactSourceType selected}) async {
    final picked = <ContactSourceType>[];

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: ContactsSourcePicker(
            sourceTypes: const [ContactSourceType.local, ContactSourceType.external],
            selected: selected,
            onSelected: picked.add,
          ),
        ),
      ),
    );

    return picked;
  }

  testWidgets('says which address book is showing without being opened', (tester) async {
    await pumpPicker(tester, selected: ContactSourceType.external);

    expect(find.text('Cloud PBX'), findsOneWidget);
  });

  testWidgets('hands the chosen address book back', (tester) async {
    final picked = await pumpPicker(tester, selected: ContactSourceType.external);

    await tester.tap(find.byKey(contactsSourcePickerKey));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Your phone').last);
    await tester.pumpAndSettle();

    expect(picked, [ContactSourceType.local]);
  });

  testWidgets('names itself for a screen reader', (tester) async {
    final handle = tester.ensureSemantics();

    await pumpPicker(tester, selected: ContactSourceType.external);

    expect(find.bySemanticsIdentifier(contactsSourcePickerId), findsOneWidget);

    handle.dispose();
  });
}
