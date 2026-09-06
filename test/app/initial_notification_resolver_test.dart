import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/initial_notification_resolver.dart';

void main() {
  test('delivers a late value exactly once after the watchdog fires', () async {
    final completer = Completer<int?>();
    final delivered = <int>[];
    final slowEvents = <Duration>[];

    final resolution = resolveInitialNotification<int>(
      load: () => completer.future,
      deliver: delivered.add,
      onSlow: slowEvents.add,
      onError: (error, stackTrace) => fail('unexpected error: $error'),
      slowThreshold: const Duration(milliseconds: 1),
    );

    await Future<void>.delayed(const Duration(milliseconds: 10));
    expect(slowEvents, hasLength(1));
    expect(delivered, isEmpty);

    completer.complete(42);
    await resolution;

    expect(delivered, [42]);
  });

  test('does not deliver a null result', () async {
    var deliveries = 0;

    await resolveInitialNotification<int>(
      load: () async => null,
      deliver: (_) => deliveries++,
      onSlow: (_) {},
      onError: (error, stackTrace) => fail('unexpected error: $error'),
    );

    expect(deliveries, 0);
  });

  test('contains resolver errors', () async {
    final expected = StateError('plugin failed');
    final errors = <Object>[];

    await resolveInitialNotification<int>(
      load: () => Future<int?>.error(expected),
      deliver: (_) => fail('must not deliver'),
      onSlow: (_) {},
      onError: (error, stackTrace) => errors.add(error),
    );

    expect(errors, [same(expected)]);
  });

  test('contains delivery and error observer errors', () async {
    await expectLater(
      resolveInitialNotification<int>(
        load: () async => 42,
        deliver: (_) => throw StateError('delivery failed'),
        onSlow: (_) {},
        onError: (error, stackTrace) => throw StateError('error observer failed'),
      ),
      completes,
    );
  });

  test('contains slow observer errors', () async {
    final completer = Completer<int?>();

    final resolution = resolveInitialNotification<int>(
      load: () => completer.future,
      deliver: (_) {},
      onSlow: (_) => throw StateError('slow observer failed'),
      onError: (error, stackTrace) => fail('unexpected error: $error'),
      slowThreshold: const Duration(milliseconds: 1),
    );

    await Future<void>.delayed(const Duration(milliseconds: 10));
    completer.complete(null);

    await expectLater(resolution, completes);
  });
}
