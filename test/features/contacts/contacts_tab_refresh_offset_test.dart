import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/contacts/contacts.dart';

import 'contacts_tab_harness.dart';

/// Where the refresh spinner is drawn.
///
/// Both contacts screens run their list BEHIND a translucent app bar, so a
/// spinner placed by the screen edge - which is what RefreshIndicator does
/// unless told otherwise - ends up a bar's height out of sight, and pulling
/// the list looks like it did nothing at all. Both lists are covered because
/// each carries its own copy of the answer.
void main() {
  // A contacts bar at its tallest: title row, source tabs, search field.
  const tallBar = 156.0;

  late ContactsTabHarness harness;

  setUp(() => harness = ContactsTabHarness());

  final people = [for (var id = 1; id <= 12; id++) buildListContact(id: id, name: 'Person $id')];

  /// Pulls the list down far enough to arm a refresh and reports where the
  /// spinner came to rest against where the bar ends.
  ///
  /// The wait is not decoration: the indicator snaps to its resting place
  /// before it calls onRefresh, so measuring on the frame after the drag would
  /// catch it mid-flight.
  Future<({double spinner, double barBottom})> pullDown(WidgetTester tester) async {
    await tester.fling(find.byType(ListView), const Offset(0, 300), 1000);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    final spinner = find.byType(RefreshProgressIndicator);
    expect(spinner, findsOneWidget, reason: 'the pull did not arm a refresh at all');

    return (spinner: tester.getTopLeft(spinner).dy, barBottom: tester.getBottomLeft(find.byType(AppBar)).dy);
  }

  testWidgets('the phone book draws its spinner below the bar, not behind it', (tester) async {
    final states = StreamController<ContactsLocalTabState>.broadcast();
    addTearDown(states.close);

    await harness.pumpLocal(tester, contacts: people, behindAppBarOfHeight: tallBar, states: states.stream);

    final (:spinner, :barBottom) = await pullDown(tester);

    expect(spinner, greaterThanOrEqualTo(barBottom));

    // The tab holds the spinner until its bloc reports a state that is no
    // longer in progress; without it the indicator spins past the test.
    states.add(ContactsLocalTabState(status: ContactsLocalTabStatus.success, contacts: people));
    await tester.pumpAndSettle();
  });

  testWidgets('the extensions list draws its spinner below the bar, not behind it', (tester) async {
    final states = StreamController<ContactsExternalTabState>.broadcast();
    addTearDown(states.close);

    await harness.pumpExternal(tester, contacts: people, behindAppBarOfHeight: tallBar, states: states.stream);

    final (:spinner, :barBottom) = await pullDown(tester);

    expect(spinner, greaterThanOrEqualTo(barBottom));

    // The tab holds the spinner until its bloc reports a state that is no
    // longer in progress; without it the indicator spins past the test.
    states.add(ContactsExternalTabState(status: ContactsExternalTabStatus.success, contacts: people));
    await tester.pumpAndSettle();
  });
}
