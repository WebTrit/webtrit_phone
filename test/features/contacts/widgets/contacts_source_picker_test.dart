import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/contacts/widgets/contacts_source_picker.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

void main() {
  const local = ContactsSourceSelection(ContactSourceType.local);
  const external = ContactsSourceSelection(ContactSourceType.external);
  const favorites = ContactsFavoritesSelection();

  Future<List<ContactsListSelection>> pumpPicker(
    WidgetTester tester, {
    required ContactsListSelection selected,
    List<ContactsListSelection> selections = const [local, external, favorites],
  }) async {
    final picked = <ContactsListSelection>[];

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: ContactsSourcePicker(selections: selections, selected: selected, onSelected: picked.add),
        ),
      ),
    );

    return picked;
  }

  testWidgets('says which list is showing without being opened', (tester) async {
    await pumpPicker(tester, selected: external);

    expect(find.text('Cloud PBX'), findsOneWidget);
  });

  testWidgets('names favourites the same way, because here they are one more list', (tester) async {
    await pumpPicker(tester, selected: favorites);

    expect(find.text('Favorites'), findsOneWidget);
  });

  testWidgets('hands the chosen list back', (tester) async {
    final picked = await pumpPicker(tester, selected: external);

    await tester.tap(find.byKey(contactsSourcePickerKey));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Your phone').last);
    await tester.pumpAndSettle();

    expect(picked, [local]);
  });

  testWidgets('offers favourites as the third entry, reachable by its own anchor', (tester) async {
    // The star on the title row this replaced had an identifier of its own, so
    // dropping the anchor rather than moving it is what breaks an end-to-end
    // run while every widget test stays green.
    final picked = await pumpPicker(tester, selected: external);

    await tester.tap(find.byKey(contactsSourcePickerKey));
    await tester.pumpAndSettle();

    expect(find.byKey(contactsSourceFavoritesKey), findsOneWidget);

    await tester.tap(find.byKey(contactsSourceFavoritesKey));
    await tester.pumpAndSettle();

    expect(picked, [favorites]);
  });

  testWidgets('leaves favourites out where the deployment does not offer them', (tester) async {
    await pumpPicker(tester, selected: external, selections: const [local, external]);

    await tester.tap(find.byKey(contactsSourcePickerKey));
    await tester.pumpAndSettle();

    expect(find.byKey(contactsSourceFavoritesKey), findsNothing);
  });

  testWidgets('names itself for a screen reader, on the node that opens it', (tester) async {
    // The name and the press have to be the same node. Split between two -
    // which is what an identifier put inside the tap target does - a screen
    // reader announces a nameless control and automation finds a name it
    // cannot activate, while a test that only looks the identifier up stays
    // green.
    final handle = tester.ensureSemantics();

    await pumpPicker(tester, selected: external);

    final named = find.bySemanticsIdentifier(contactsSourcePickerId);
    expect(named, findsOneWidget);
    expect(tester.getSemantics(named), isSemantics(hasTapAction: true, isButton: true));

    handle.dispose();
  });
}
