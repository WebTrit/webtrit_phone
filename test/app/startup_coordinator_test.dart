import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/startup_coordinator.dart';

void main() {
  test('waits for both branches and returns the bootstrap result', () async {
    final systemUi = Completer<void>();
    final bootstrap = Completer<Object>();
    final result = Object();
    var completed = false;

    final startup = waitForStartup<Object>(
      systemUi: systemUi.future,
      bootstrap: bootstrap.future,
      disposeBootstrapResult: (_) => fail('must not dispose a successful startup'),
    )..then((_) => completed = true);

    bootstrap.complete(result);
    await Future<void>.delayed(Duration.zero);
    expect(completed, isFalse);

    systemUi.complete();
    expect(await startup, same(result));
  });

  test('starts observing both branches immediately', () async {
    final started = <String>[];
    final systemUi = Completer<void>();
    final bootstrap = Completer<int>();

    Future<void> startSystemUi() {
      started.add('system-ui');
      return systemUi.future;
    }

    Future<int> startBootstrap() {
      started.add('bootstrap');
      return bootstrap.future;
    }

    final systemUiFuture = startSystemUi();
    final bootstrapFuture = startBootstrap();
    final startup = waitForStartup<int>(
      systemUi: systemUiFuture,
      bootstrap: bootstrapFuture,
      disposeBootstrapResult: (_) {},
    );

    expect(started, ['system-ui', 'bootstrap']);
    systemUi.complete();
    bootstrap.complete(42);
    expect(await startup, 42);
  });

  test('preserves a bootstrap failure', () async {
    final expected = StateError('bootstrap failed');
    var disposals = 0;

    await expectLater(
      waitForStartup<int>(
        systemUi: Future<void>.value(),
        bootstrap: Future<int>.error(expected),
        disposeBootstrapResult: (_) => disposals++,
      ),
      throwsA(same(expected)),
    );
    expect(disposals, 0);
  });

  test('disposes a successful bootstrap result when system UI fails', () async {
    final expected = StateError('system UI failed');
    final result = Object();
    final disposed = <Object>[];

    await expectLater(
      waitForStartup<Object>(
        systemUi: Future<void>.error(expected),
        bootstrap: Future<Object>.value(result),
        disposeBootstrapResult: disposed.add,
      ),
      throwsA(same(expected)),
    );
    expect(disposed, [same(result)]);
  });

  test('cleanup failure does not mask the startup failure', () async {
    final expected = StateError('system UI failed');

    await expectLater(
      waitForStartup<int>(
        systemUi: Future<void>.error(expected),
        bootstrap: Future<int>.value(42),
        disposeBootstrapResult: (_) => throw StateError('cleanup failed'),
      ),
      throwsA(same(expected)),
    );
  });
}
