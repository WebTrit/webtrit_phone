import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/services/services.dart';
import 'package:webtrit_phone/utils/utils.dart';

class _MockConnectivity extends Mock implements Connectivity {}

class _ControlledConnectivityChecker implements ConnectivityChecker {
  final probes = <Completer<bool>>[];
  var disposed = false;

  @override
  Future<bool> checkConnection() {
    final probe = Completer<bool>();
    probes.add(probe);
    return probe.future;
  }

  @override
  Future<void> dispose() async {
    disposed = true;
  }
}

void main() {
  late StreamController<List<ConnectivityResult>> changes;
  late _MockConnectivity connectivity;
  late _ControlledConnectivityChecker checker;
  late ConnectivityServiceImpl service;
  var serviceDisposed = false;

  setUp(() async {
    changes = StreamController<List<ConnectivityResult>>.broadcast(sync: true);
    connectivity = _MockConnectivity();
    checker = _ControlledConnectivityChecker();

    when(connectivity.checkConnectivity).thenAnswer((_) async => const [ConnectivityResult.wifi]);
    when(() => connectivity.onConnectivityChanged).thenAnswer((_) => changes.stream);

    service = await ConnectivityServiceImpl.create(connectivityChecker: checker, connectivity: connectivity);
    serviceDisposed = false;
  });

  tearDown(() async {
    if (!serviceDisposed) await service.dispose();
    await changes.close();
  });

  test('a stale probe cannot overwrite the latest wifi result after a flap', () async {
    final onlineStates = <bool>[];
    final subscription = service.connectionStream.listen(onlineStates.add);
    addTearDown(subscription.cancel);

    changes.add(const [ConnectivityResult.wifi]);
    changes.add(const [ConnectivityResult.none]);
    changes.add(const [ConnectivityResult.wifi]);

    expect(checker.probes, hasLength(2));

    checker.probes[1].complete(true);
    await pumpEventQueue();
    expect(onlineStates, [true]);

    checker.probes[0].complete(false);
    await pumpEventQueue();
    expect(onlineStates, [true], reason: 'the first wifi probe was superseded by the later wifi event');
  });

  test('the newest probe wins when consecutive events use the same transport', () async {
    final onlineStates = <bool>[];
    final subscription = service.connectionStream.listen(onlineStates.add);
    addTearDown(subscription.cancel);

    changes.add(const [ConnectivityResult.wifi]);
    changes.add(const [ConnectivityResult.wifi]);

    expect(checker.probes, hasLength(2));

    checker.probes[1].complete(true);
    await pumpEventQueue();
    checker.probes[0].complete(false);
    await pumpEventQueue();

    expect(onlineStates, [true]);
  });

  test('an offline event supersedes an active online probe', () async {
    final onlineStates = <bool>[];
    final subscription = service.connectionStream.listen(onlineStates.add);
    addTearDown(subscription.cancel);

    changes.add(const [ConnectivityResult.wifi]);
    changes.add(const [ConnectivityResult.none]);
    await pumpEventQueue();

    expect(onlineStates, [false]);

    checker.probes.single.complete(true);
    await pumpEventQueue();
    expect(onlineStates, [false], reason: 'the transport is still offline when the old probe completes');
  });

  test('a probe completing after disposal does not emit', () async {
    final onlineStates = <bool>[];
    final subscription = service.connectionStream.listen(onlineStates.add);

    changes.add(const [ConnectivityResult.wifi]);
    expect(checker.probes, hasLength(1));

    await service.dispose();
    serviceDisposed = true;
    checker.probes.single.complete(true);
    await pumpEventQueue();

    expect(onlineStates, isEmpty);
    expect(checker.disposed, isTrue);
    await subscription.cancel();
  });
}
