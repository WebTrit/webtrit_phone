import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/startup_wave.dart';
import 'package:webtrit_phone/common/common.dart';

class _Recorded implements Disposable {
  _Recorded(this.name, this.released, {this.fail = false});

  final String name;
  final List<String> released;
  final bool fail;

  @override
  Future<void> dispose() async {
    released.add(name);
    if (fail) throw StateError('release $name failed');
  }
}

void main() {
  test('returns successful values in declared order', () async {
    final first = Completer<Object>();
    final second = Completer<Object>();
    final result = settleStartupWave([first.future, second.future]);

    second.complete('second');
    first.complete('first');

    await expectLater(result, completion(['first', 'second']));
  });

  test('waits for every sibling before reporting an error', () async {
    final slow = Completer<Object>();
    final result = settleStartupWave([Future<Object>.error(StateError('failed')), slow.future]);
    var completed = false;
    result.whenComplete(() => completed = true).ignore();

    await Future<void>.delayed(Duration.zero);
    expect(completed, isFalse);

    slow.complete('slow');
    await expectLater(result, throwsA(isA<StateError>()));
  });

  test('reports the first declared error rather than the first completed error', () async {
    final first = Completer<Object>();
    final second = Completer<Object>();
    final result = settleStartupWave([first.future, second.future]);

    second.completeError(ArgumentError('second'));
    first.completeError(StateError('first'));

    await expectLater(result, throwsA(isA<StateError>().having((error) => error.message, 'message', 'first')));
  });

  test('rolls successful disposables back in reverse declared order', () async {
    final released = <String>[];

    await expectLater(
      settleStartupWave([
        Future.value(_Recorded('first', released)),
        Future<Object>.error(StateError('failed')),
        Future.value(_Recorded('third', released)),
      ]),
      throwsStateError,
    );

    expect(released, ['third', 'first']);
  });

  test('a rollback failure does not mask the startup error or stop cleanup', () async {
    final released = <String>[];

    await expectLater(
      settleStartupWave([
        Future.value(_Recorded('first', released)),
        Future<Object>.error(ArgumentError('startup failed')),
        Future.value(_Recorded('third', released, fail: true)),
      ]),
      throwsA(isA<ArgumentError>()),
    );

    expect(released, ['third', 'first']);
  });
}
