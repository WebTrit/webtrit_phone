import 'dart:async';
import 'package:webtrit_phone/common/common.dart';

/// A flexible mock repository implementing [Suspendable].
class MockSuspendableRepository implements Suspendable {
  MockSuspendableRepository({this.workTime, this.onStart});

  int calls = 0;
  final Duration? workTime;
  final void Function()? onStart;

  @override
  Future<void> suspend() async {
    onStart?.call();
    calls++;
    if (workTime != null) {
      await Future<void>.delayed(workTime!);
    }
  }

  void reset() {
    calls = 0;
  }

  @override
  String toString() => 'MockSuspendableRepository(calls=$calls, workTime=$workTime)';
}
