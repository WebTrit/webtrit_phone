import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/contacts/contacts.dart';

import 'contacts_tab_harness.dart';

/// How favourites show up in the three contacts lists.
///
/// The address-book lists only mark them; the list of favourites themselves is
/// a list of its own, spanning every address book. All three are covered
/// because each carries its own copy of the answer: they are separate widgets
/// over separate blocs, and a fix applied to one is not applied to the others.
void main() {
  final anna = buildListContact(id: 1, name: 'Anna', favoriteNumber: true);
  final bob = buildListContact(id: 2, name: 'Bob');

  late ContactsTabHarness harness;

  setUp(() => harness = ContactsTabHarness());

  final stars = find.byIcon(Icons.star);

  group('the extensions list', () {
    testWidgets('shows everyone in the address book', (tester) async {
      await harness.pumpExternal(tester, contacts: [anna, bob]);

      expect(find.text('Anna'), findsOneWidget);
      expect(find.text('Bob'), findsOneWidget);
    });

    testWidgets('marks the favourites when the screen asks for it', (tester) async {
      await harness.pumpExternal(tester, contacts: [anna, bob], markFavorites: true);

      final annaStar = find.descendant(
        of: find.ancestor(of: find.text('Anna'), matching: find.byType(ContactTileAdapter)),
        matching: stars,
      );
      final bobStar = find.descendant(
        of: find.ancestor(of: find.text('Bob'), matching: find.byType(ContactTileAdapter)),
        matching: stars,
      );

      expect(annaStar, findsOneWidget);
      expect(bobStar, findsNothing);
    });

    testWidgets('and marks nobody on the screen that does not', (tester) async {
      await harness.pumpExternal(tester, contacts: [anna, bob]);

      expect(stars, findsNothing);
    });
  });

  group('the phone book list', () {
    testWidgets('shows everyone in the address book', (tester) async {
      await harness.pumpLocal(tester, contacts: [anna, bob]);

      expect(find.text('Anna'), findsOneWidget);
      expect(find.text('Bob'), findsOneWidget);
    });

    testWidgets('marks the favourites when the screen asks for it', (tester) async {
      await harness.pumpLocal(tester, contacts: [anna, bob], markFavorites: true);

      expect(stars, findsOneWidget);
    });

    testWidgets('and marks nobody on the screen that does not', (tester) async {
      await harness.pumpLocal(tester, contacts: [anna, bob]);

      expect(stars, findsNothing);
    });

    testWidgets('keeps the permission notice and its way out', (tester) async {
      // A phone book nobody let us read is a different problem from an empty
      // one, and the list must not hide the one way out of it.
      await harness.pumpLocal(tester, contacts: const [], status: ContactsLocalTabStatus.permissionFailure);

      expect(find.textContaining('no permissions'), findsOneWidget);
      expect(find.textContaining('Grant access'), findsOneWidget);
    });
  });

  group('the favourites list', () {
    testWidgets('draws the rows its bloc hands over, starred', (tester) async {
      // Every row is here for one reason, and the star is how it leaves again.
      await harness.pumpFavorites(tester, contacts: [anna]);

      expect(find.text('Anna'), findsOneWidget);
      expect(stars, findsOneWidget);
    });

    testWidgets('says so in words when nobody is marked', (tester) async {
      // Not a failure and not a slow fetch: nobody has been starred yet, and
      // an empty screen here reads like a fault.
      await harness.pumpFavorites(tester, contacts: const []);

      expect(find.textContaining('No favorites'), findsOneWidget);
      expect(find.byType(ContactTileAdapter), findsNothing);
    });

    testWidgets('and tells a fruitless search apart from that', (tester) async {
      // Telling someone how to star a contact answers a question they did not
      // ask when what they did was type a name that matched nobody.
      await harness.pumpFavorites(tester, contacts: const [], searching: true);

      expect(find.textContaining('No contacts found'), findsOneWidget);
      expect(find.textContaining('No favorites'), findsNothing);
    });

    testWidgets('waits rather than claiming to be empty before the first read', (tester) async {
      await harness.pumpFavorites(tester, contacts: const [], status: ContactsFavoritesTabStatus.initial);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.textContaining('No favorites'), findsNothing);
    });
  });
}
