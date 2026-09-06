import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/services/services.dart';

class MockPollingWorker extends Mock implements PollingWorker {}

class MockPollingService extends Mock implements PollingService {}

class MockPollingTaskHandle extends Mock implements PollingTaskHandle {}

class FakePollingRegistration extends Fake implements PollingRegistration {}

final class TestPollingWorkerOwner extends PollingWorkerOwner<PollingWorker> {
  TestPollingWorkerOwner({required super.worker, required super.pollingService, required super.interval});

  void requestInvalidation({Duration after = Duration.zero}) => invalidatePollingTask(after: after);
}

void main() {
  setUpAll(() {
    registerFallbackValue(FakePollingRegistration());
    registerFallbackValue(Duration.zero);
  });

  late MockPollingWorker worker;
  late MockPollingService pollingService;
  late MockPollingTaskHandle task;

  setUp(() {
    worker = MockPollingWorker();
    pollingService = MockPollingService();
    task = MockPollingTaskHandle();

    when(() => pollingService.register(any())).thenReturn(task);
    when(() => task.unregister()).thenReturn(null);
    when(() => worker.dispose()).thenAnswer((_) async {});
  });

  TestPollingWorkerOwner buildOwner() =>
      TestPollingWorkerOwner(worker: worker, pollingService: pollingService, interval: const Duration(minutes: 1));

  test('registers exactly the owned worker at the requested interval', () {
    buildOwner();

    final registration = verify(() => pollingService.register(captureAny())).captured.single as PollingRegistration;
    expect(registration.listener, same(worker));
    expect(registration.interval, const Duration(minutes: 1));
  });

  test('forwards only task state and manual execution capabilities', () async {
    const currentState = PollingTaskState(phase: PollingTaskPhase.running);
    final stateStream = Stream.value(currentState);
    when(() => task.state).thenReturn(currentState);
    when(() => task.states).thenAnswer((_) => stateStream);
    when(() => task.runNow()).thenAnswer((_) async {});
    final owner = buildOwner();

    expect(owner.state, same(currentState));
    expect(owner.states, same(stateStream));
    await owner.runNow();

    verify(() => task.runNow()).called(1);
  });

  test('lets a feature owner invalidate its active registration', () {
    when(() => task.isRegistered).thenReturn(true);
    when(() => task.invalidate(after: any(named: 'after'))).thenReturn(null);
    final owner = buildOwner();

    owner.requestInvalidation(after: const Duration(seconds: 1));

    verify(() => task.invalidate(after: const Duration(seconds: 1))).called(1);
  });

  test('ignores invalidation after the registration has already stopped', () {
    when(() => task.isRegistered).thenReturn(false);
    final owner = buildOwner();

    owner.requestInvalidation();

    verifyNever(() => task.invalidate(after: any(named: 'after')));
  });

  test('unregisters before worker disposal and ignores repeated teardown', () async {
    when(() => task.isRegistered).thenReturn(true);
    final owner = buildOwner();

    await owner.dispose();
    owner.requestInvalidation();
    await owner.dispose();

    verifyInOrder([() => task.unregister(), () => worker.dispose()]);
    verifyNever(() => task.invalidate(after: any(named: 'after')));
    verifyNoMoreInteractions(worker);
  });
}
