import 'dart:async';
import 'package:webtrit_phone/common/common.dart';

/// A flexible mock repository implementing [Refreshable].
class MockRefreshableRepository implements Refreshable {
  MockRefreshableRepository({
    this.workTime,
    this.failTimes = 0,
    this.neverComplete = false,
    this.onStart,
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now;

  int calls = 0;
  int failTimes;
  final Duration? workTime;
  final bool neverComplete;
  final void Function()? onStart;

  final DateTime Function() _now;
  final List<DateTime> callTimestamps = <DateTime>[];

  Completer<void>? _neverCompleter;

  @override
  Future<void> refresh() async {
    onStart?.call();
    calls++;
    callTimestamps.add(_now());

    if (failTimes > 0) {
      failTimes--;
      throw StateError('MockRefreshableRepository configured to fail. Remaining: $failTimes');
    }

    if (neverComplete) {
      _neverCompleter ??= Completer<void>();
      await _neverCompleter!.future;
      return;
    }

    if (workTime != null) {
      await Future<void>.delayed(workTime!);
    }
  }

  int get callCount => calls; // 👈 alias

  void reset() {
    calls = 0;
    callTimestamps.clear();
    _neverCompleter = null;
  }

  @override
  String toString() =>
      'MockRefreshableRepository(calls=$calls, failTimes=$failTimes, workTime=$workTime, neverComplete=$neverComplete)';
}
