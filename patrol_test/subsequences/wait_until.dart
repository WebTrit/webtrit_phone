import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

/// Pumps until [condition] holds, failing with [description] on [timeout].
///
/// The one wait primitive for bench conditions that no widget finder can
/// await (a request appearing in a log, an indicator disappearing): a
/// single place owns the pump cadence and the deadline shape instead of
/// every test hand-rolling its own loop.
Future<DateTime> waitUntil(
  PatrolIntegrationTester $,
  bool Function() condition, {
  required Duration timeout,
  required String description,
  Duration step = const Duration(milliseconds: 100),
}) async {
  final deadline = DateTime.now().add(timeout);
  while (!condition()) {
    if (DateTime.now().isAfter(deadline)) {
      fail(description);
    }
    await $.pump(step);
  }
  return DateTime.now();
}
