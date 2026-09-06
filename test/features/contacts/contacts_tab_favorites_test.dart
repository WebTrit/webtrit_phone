import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/contacts/contacts.dart';

import 'contacts_tab_harness.dart';

/// How favourites show up in the address-book lists.
///
/// These lists only mark them; the list of favourites themselves is the
/// favourites section's own, drawn by `FavoritesList` and covered by that
/// feature's tests. Both address books are covered here because each carries
/// its own copy of the answer: they are separate widgets over separate blocs,
/// and a fix applied to one is not applied to the other.
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
}
