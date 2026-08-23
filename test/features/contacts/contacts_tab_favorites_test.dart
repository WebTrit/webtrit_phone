import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/contacts/contacts.dart';

import 'contacts_tab_harness.dart';

/// What each contacts list does when the screen around it asks for favourites
/// only.
///
/// Both lists are covered because both carry their own copy of the answer:
/// the phone book and the extensions directory are separate widgets over
/// separate blocs, and a fix applied to one of them is not applied to the
/// other.
void main() {
  final anna = buildListContact(id: 1, name: 'Anna', favoriteNumber: true);
  final bob = buildListContact(id: 2, name: 'Bob');

  late ContactsTabHarness harness;

  setUp(() => harness = ContactsTabHarness());

  final stars = find.byIcon(Icons.star);

  group('the extensions list', () {
    testWidgets('shows everyone while the filter is off', (tester) async {
      await harness.pumpExternal(tester, contacts: [anna, bob]);

      expect(find.text('Anna'), findsOneWidget);
      expect(find.text('Bob'), findsOneWidget);
    });

    testWidgets('keeps only favourites while it is on', (tester) async {
      await harness.pumpExternal(tester, contacts: [anna, bob], favoritesOnly: true);

      expect(find.text('Anna'), findsOneWidget);
      expect(find.text('Bob'), findsNothing);
    });

    testWidgets('says so in words when nobody is marked', (tester) async {
      // Not a failure and not a slow fetch: the list arrived, the filter is
      // simply keeping nobody, and an empty screen here reads like a fault.
      await harness.pumpExternal(tester, contacts: [bob], favoritesOnly: true);

      expect(find.textContaining('No favorites'), findsOneWidget);
      expect(find.byType(ContactTileAdapter), findsNothing);
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
    testWidgets('shows everyone while the filter is off', (tester) async {
      await harness.pumpLocal(tester, contacts: [anna, bob]);

      expect(find.text('Anna'), findsOneWidget);
      expect(find.text('Bob'), findsOneWidget);
    });

    testWidgets('keeps only favourites while it is on', (tester) async {
      await harness.pumpLocal(tester, contacts: [anna, bob], favoritesOnly: true);

      expect(find.text('Anna'), findsOneWidget);
      expect(find.text('Bob'), findsNothing);
    });

    testWidgets('says so in words when nobody is marked', (tester) async {
      await harness.pumpLocal(tester, contacts: [bob], favoritesOnly: true);

      expect(find.textContaining('No favorites'), findsOneWidget);
      expect(find.byType(ContactTileAdapter), findsNothing);
    });

    testWidgets('marks the favourites when the screen asks for it', (tester) async {
      await harness.pumpLocal(tester, contacts: [anna, bob], markFavorites: true);

      expect(stars, findsOneWidget);
    });

    testWidgets('and marks nobody on the screen that does not', (tester) async {
      await harness.pumpLocal(tester, contacts: [anna, bob]);

      expect(stars, findsNothing);
    });

    testWidgets('leaves the permission notice alone when the filter is on', (tester) async {
      // A phone book nobody let us read is a different problem, and the
      // filter must not hide the one way out of it.
      await harness.pumpLocal(
        tester,
        contacts: const [],
        favoritesOnly: true,
        status: ContactsLocalTabStatus.permissionFailure,
      );

      expect(find.textContaining('no permissions'), findsOneWidget);
      expect(find.textContaining('Grant access'), findsOneWidget);
    });
  });
}
