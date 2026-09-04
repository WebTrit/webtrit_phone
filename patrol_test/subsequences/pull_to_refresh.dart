import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'wait_until.dart';

/// Performs a pull-to-refresh on the list containing [itemFinder] and waits
/// for the indicator to close.
///
/// The drag distance is derived from the list's own height: RefreshIndicator
/// arms only when the overscroll exceeds a fraction of the viewport, so a
/// fixed pixel offset silently degrades into a plain scroll on tall screens.
/// The indicator is asserted to have actually appeared - a pull that never
/// armed must fail loudly, not pass vacuously.
Future<void> pullToRefresh(
  PatrolIntegrationTester $,
  PatrolFinder itemFinder, {
  required String closeReason,
  Duration closeTimeout = const Duration(seconds: 15),
}) async {
  final listFinder = find.ancestor(of: itemFinder.first.finder, matching: find.byType(Scrollable)).first;
  final height = $.tester.getSize(listFinder).height;

  await $.tester.fling(itemFinder.first.finder, Offset(0, height * 0.5), 1200);
  await $.pump();

  expect(
    find.byType(RefreshProgressIndicator),
    findsOneWidget,
    reason: 'the pull gesture must actually arm the refresh indicator',
  );

  await waitUntil(
    $,
    () => find.byType(RefreshProgressIndicator).evaluate().isEmpty,
    timeout: closeTimeout,
    description: closeReason,
  );
}
