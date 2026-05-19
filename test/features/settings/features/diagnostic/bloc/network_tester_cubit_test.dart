import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/settings/features/diagnostic/bloc/network_tester_cubit.dart';
import 'package:webtrit_phone/utils/utils.dart';

class _MockConnectivity extends Mock implements Connectivity {}

class _MockIceChecker extends Mock implements IceChecker {}

CandidateInfo _candidate({
  String address = '203.0.113.1',
  int port = 12345,
  IceType type = IceType.srflx,
  IceTransport transport = IceTransport.udp,
}) => CandidateInfo(
  mid: '0',
  type: type,
  transport: transport,
  network: IceNetwork.ipv4,
  address: address,
  port: port,
  generation: 0,
  usernameFragment: 'ufrag',
  priority: '123',
  networkCost: '',
  foundation: 'abc',
  relatedAddress: '',
  relatedPort: 0,
  protocol: '',
);

void main() {
  group('NetworkTesterCubit', () {
    late _MockConnectivity connectivity;
    late _MockIceChecker iceChecker;
    late StreamController<List<ConnectivityResult>> connectivityController;

    setUp(() {
      connectivity = _MockConnectivity();
      iceChecker = _MockIceChecker();
      connectivityController = StreamController<List<ConnectivityResult>>(sync: true);

      when(() => connectivity.onConnectivityChanged).thenAnswer((_) => connectivityController.stream);
    });

    tearDown(() {
      connectivityController.close();
    });

    NetworkTesterCubit buildCubit({List<ConnectivityResult> initialNetworks = const [ConnectivityResult.none]}) {
      when(() => connectivity.checkConnectivity()).thenAnswer((_) async => initialNetworks);
      return NetworkTesterCubit(iceChecker: iceChecker, connectivity: connectivity);
    }

    test('initial state has empty candidates, no networks, and initial gathering status', () {
      fakeAsync((async) {
        when(() => connectivity.checkConnectivity()).thenAnswer((_) async => [ConnectivityResult.none]);
        final cubit = NetworkTesterCubit(iceChecker: iceChecker, connectivity: connectivity);

        expect(cubit.state.candidates, isEmpty);
        expect(cubit.state.networks, isEmpty);
        expect(cubit.state.gatheringStatus, IceGatheringStatus.initial);

        unawaited(cubit.close());
      });
    });

    group('connectivity init', () {
      test('updates networks and triggers refresh when online', () {
        fakeAsync((async) {
          final gatherController = StreamController<CandidateInfo>(sync: true);
          when(
            () => iceChecker.gatherCandidates(iceServers: any(named: 'iceServers')),
          ).thenAnswer((_) => gatherController.stream);

          final cubit = buildCubit(initialNetworks: [ConnectivityResult.wifi]);
          async.flushMicrotasks();

          expect(cubit.state.networks, [ConnectivityResult.wifi]);
          expect(cubit.state.gatheringStatus, IceGatheringStatus.gathering);

          gatherController.close();
          unawaited(cubit.close());
        });
      });

      test('sets complete immediately when offline', () {
        fakeAsync((async) {
          final cubit = buildCubit(initialNetworks: [ConnectivityResult.none]);
          async.flushMicrotasks();

          expect(cubit.state.networks, [ConnectivityResult.none]);
          expect(cubit.state.gatheringStatus, IceGatheringStatus.complete);
          verifyNever(() => iceChecker.gatherCandidates(iceServers: any(named: 'iceServers')));

          unawaited(cubit.close());
        });
      });
    });

    group('refresh', () {
      test('accumulates candidates as they arrive from iceChecker', () {
        fakeAsync((async) {
          final gatherController = StreamController<CandidateInfo>(sync: true);
          when(
            () => iceChecker.gatherCandidates(iceServers: any(named: 'iceServers')),
          ).thenAnswer((_) => gatherController.stream);

          final cubit = buildCubit(initialNetworks: [ConnectivityResult.wifi]);
          async.flushMicrotasks();

          final c1 = _candidate(address: '203.0.113.1', port: 10001, type: IceType.srflx);
          final c2 = _candidate(address: '203.0.113.2', port: 10002, type: IceType.relay);
          gatherController.add(c1);
          gatherController.add(c2);

          expect(cubit.state.candidates, [c1, c2]);
          expect(cubit.state.gatheringStatus, IceGatheringStatus.gathering);

          gatherController.close();
          unawaited(cubit.close());
        });
      });

      test('sets complete when iceChecker stream closes', () {
        fakeAsync((async) {
          final gatherController = StreamController<CandidateInfo>(sync: true);
          when(
            () => iceChecker.gatherCandidates(iceServers: any(named: 'iceServers')),
          ).thenAnswer((_) => gatherController.stream);

          final cubit = buildCubit(initialNetworks: [ConnectivityResult.wifi]);
          async.flushMicrotasks();

          gatherController.add(_candidate());
          gatherController.close();
          async.flushMicrotasks();

          expect(cubit.state.gatheringStatus, IceGatheringStatus.complete);
          expect(cubit.state.candidates, hasLength(1));

          unawaited(cubit.close());
        });
      });

      test('sets complete on iceChecker stream error', () {
        fakeAsync((async) {
          final gatherController = StreamController<CandidateInfo>(sync: true);
          when(
            () => iceChecker.gatherCandidates(iceServers: any(named: 'iceServers')),
          ).thenAnswer((_) => gatherController.stream);

          final cubit = buildCubit(initialNetworks: [ConnectivityResult.wifi]);
          async.flushMicrotasks();

          gatherController.addError(Exception('WebRTC error'));
          async.flushMicrotasks();

          expect(cubit.state.gatheringStatus, IceGatheringStatus.complete);

          unawaited(cubit.close());
        });
      });

      test('clears previous candidates and restarts gathering on refresh', () async {
        final firstController = StreamController<CandidateInfo>(sync: true);
        final secondController = StreamController<CandidateInfo>(sync: true);
        var callCount = 0;
        when(() => iceChecker.gatherCandidates(iceServers: any(named: 'iceServers'))).thenAnswer((_) {
          callCount++;
          return callCount == 1 ? firstController.stream : secondController.stream;
        });

        final cubit = buildCubit(initialNetworks: [ConnectivityResult.wifi]);
        await Future<void>.delayed(Duration.zero); // let init microtasks complete

        firstController.add(_candidate(address: '203.0.113.1', port: 1));
        expect(cubit.state.candidates, hasLength(1));

        await cubit.refresh();

        expect(cubit.state.candidates, isEmpty);
        expect(cubit.state.gatheringStatus, IceGatheringStatus.gathering);

        secondController.add(_candidate(address: '203.0.113.2', port: 2));
        expect(cubit.state.candidates, hasLength(1));
        expect(cubit.state.candidates.first.address, '203.0.113.2');

        firstController.close();
        secondController.close();
        await cubit.close();
      });

      test('skips gathering when no network on refresh', () {
        fakeAsync((async) {
          final cubit = buildCubit(initialNetworks: [ConnectivityResult.none]);
          async.flushMicrotasks();

          cubit.refresh();
          async.flushMicrotasks();

          expect(cubit.state.gatheringStatus, IceGatheringStatus.complete);
          verifyNever(() => iceChecker.gatherCandidates(iceServers: any(named: 'iceServers')));

          unawaited(cubit.close());
        });
      });
    });

    group('connectivity changes', () {
      test('updates networks and re-gathers on connectivity change', () {
        fakeAsync((async) {
          final gatherController = StreamController<CandidateInfo>(sync: true);
          when(
            () => iceChecker.gatherCandidates(iceServers: any(named: 'iceServers')),
          ).thenAnswer((_) => gatherController.stream);

          final cubit = buildCubit(initialNetworks: [ConnectivityResult.none]);
          async.flushMicrotasks();

          expect(cubit.state.gatheringStatus, IceGatheringStatus.complete);

          connectivityController.add([ConnectivityResult.wifi]);
          async.flushMicrotasks();

          expect(cubit.state.networks, [ConnectivityResult.wifi]);
          expect(cubit.state.gatheringStatus, IceGatheringStatus.gathering);

          gatherController.close();
          unawaited(cubit.close());
        });
      });

      test('clears candidates when connectivity changes', () async {
        final firstController = StreamController<CandidateInfo>(sync: true);
        final secondController = StreamController<CandidateInfo>(sync: true);
        var callCount = 0;
        when(() => iceChecker.gatherCandidates(iceServers: any(named: 'iceServers'))).thenAnswer((_) {
          callCount++;
          return callCount == 1 ? firstController.stream : secondController.stream;
        });

        final cubit = buildCubit(initialNetworks: [ConnectivityResult.wifi]);
        await Future<void>.delayed(Duration.zero); // let init microtasks complete

        firstController.add(_candidate());
        expect(cubit.state.candidates, hasLength(1));

        connectivityController.add([ConnectivityResult.mobile]);
        await Future<void>.delayed(Duration.zero); // let cancel() + refresh() microtasks complete

        expect(cubit.state.candidates, isEmpty);
        expect(cubit.state.networks, [ConnectivityResult.mobile]);
        expect(cubit.state.gatheringStatus, IceGatheringStatus.gathering);

        firstController.close();
        secondController.close();
        await cubit.close();
      });
    });

    group('effectiveCandidates', () {
      test('excludes loopback IPv4 candidates', () {
        fakeAsync((async) {
          final gatherController = StreamController<CandidateInfo>(sync: true);
          when(
            () => iceChecker.gatherCandidates(iceServers: any(named: 'iceServers')),
          ).thenAnswer((_) => gatherController.stream);

          final cubit = buildCubit(initialNetworks: [ConnectivityResult.wifi]);
          async.flushMicrotasks();

          final loopback = _candidate(address: '127.0.0.1', type: IceType.host);
          final public = _candidate(address: '203.0.113.1', type: IceType.srflx);
          gatherController.add(loopback);
          gatherController.add(public);

          expect(cubit.state.candidates, hasLength(2));
          expect(cubit.state.effectiveCandidates.toList(), [public]);

          gatherController.close();
          unawaited(cubit.close());
        });
      });

      test('excludes loopback IPv6 candidates', () {
        fakeAsync((async) {
          final gatherController = StreamController<CandidateInfo>(sync: true);
          when(
            () => iceChecker.gatherCandidates(iceServers: any(named: 'iceServers')),
          ).thenAnswer((_) => gatherController.stream);

          final cubit = buildCubit(initialNetworks: [ConnectivityResult.wifi]);
          async.flushMicrotasks();

          final loopback6 = _candidate(address: '::1', type: IceType.host);
          final public = _candidate(address: '203.0.113.1', type: IceType.srflx);
          gatherController.add(loopback6);
          gatherController.add(public);

          expect(cubit.state.effectiveCandidates.toList(), [public]);

          gatherController.close();
          unawaited(cubit.close());
        });
      });
    });

    group('NetworkTesterState', () {
      test('copyWith preserves unchanged fields', () {
        const state = NetworkTesterState(gatheringStatus: IceGatheringStatus.gathering);
        final updated = state.copyWith(gatheringStatus: IceGatheringStatus.complete);

        expect(updated.gatheringStatus, IceGatheringStatus.complete);
        expect(updated.candidates, isEmpty);
        expect(updated.networks, isEmpty);
      });

      test('equality holds for identical states', () {
        const a = NetworkTesterState();
        const b = NetworkTesterState();
        expect(a, equals(b));
      });

      test('equality detects gatheringStatus difference', () {
        const a = NetworkTesterState(gatheringStatus: IceGatheringStatus.gathering);
        const b = NetworkTesterState(gatheringStatus: IceGatheringStatus.complete);
        expect(a, isNot(equals(b)));
      });
    });
  });
}
