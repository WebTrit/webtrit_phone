import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/cdrs/cdrs.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class MockCdrsLocalRepository extends Mock implements CdrsLocalRepository {}

class MockCdrsRemoteRepository extends Mock implements CdrsRemoteRepository {}

CdrRecord _record(String id) => CdrRecord(
  callId: id,
  direction: CallDirection.incoming,
  status: CdrStatus.accepted,
  callee: '1000',
  calleeNumber: '1000',
  caller: '2000',
  callerNumber: '2000',
  connectTime: DateTime(2026, 1, 1),
  disconnectTime: DateTime(2026, 1, 1),
  disconnectReason: 'normal',
  duration: const Duration(seconds: 10),
);

void main() {
  late MockCdrsLocalRepository local;
  late MockCdrsRemoteRepository remote;

  setUp(() {
    local = MockCdrsLocalRepository();
    remote = MockCdrsRemoteRepository();
    when(() => local.events).thenAnswer((_) => const Stream<CdrRecordsEvent>.empty());
  });

  group('FullRecentCdrsCubit.init', () {
    test('empty local cache keeps isLoading until the initial sync resolves', () async {
      final syncCompleter = Completer<void>();
      var call = 0;
      when(() => local.getHistory(limit: any(named: 'limit'))).thenAnswer((_) async {
        call++;
        return call == 1 ? <CdrRecord>[] : [_record('a')];
      });

      final cubit = FullRecentCdrsCubit(local, remote, initialSyncDone: syncCompleter.future);
      final future = cubit.init();

      // Local read resolved and returned empty, but the sync is still running:
      // the loader must stay visible instead of showing an empty list.
      await Future<void>.delayed(const Duration(milliseconds: 10));
      expect(cubit.state.isLoading, isTrue);
      expect(cubit.state.records, isEmpty);

      syncCompleter.complete();
      await future;

      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.records, [_record('a')]);
      await cubit.close();
    });

    test('non-empty local cache clears isLoading immediately without waiting', () async {
      when(() => local.getHistory(limit: any(named: 'limit'))).thenAnswer((_) async => [_record('a')]);

      // A sync future that never completes: init must not await it.
      final cubit = FullRecentCdrsCubit(local, remote, initialSyncDone: Completer<void>().future);
      await cubit.init();

      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.records, [_record('a')]);
      await cubit.close();
    });

    test('without a sync signal falls back to clearing isLoading after the local read', () async {
      when(() => local.getHistory(limit: any(named: 'limit'))).thenAnswer((_) async => <CdrRecord>[]);

      final cubit = FullRecentCdrsCubit(local, remote);
      await cubit.init();

      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.records, isEmpty);
      await cubit.close();
    });
  });

  group('MissedRecentCdrsCubit.init', () {
    setUp(() {
      when(
        () => local.getHistory(
          number: any(named: 'number'),
          destination: any(named: 'destination'),
          status: any(named: 'status'),
          direction: any(named: 'direction'),
          from: any(named: 'from'),
          to: any(named: 'to'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => <CdrRecord>[]);
      when(() => local.getFirstRecordTime()).thenAnswer((_) async => null);
      when(() => local.upsertCdrs(any(), silent: any(named: 'silent'))).thenAnswer((_) async {});
      when(
        () => remote.getHistory(
          to: any(named: 'to'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => <CdrRecord>[]);
    });

    test('empty local cache keeps isLoading until the initial sync and scan resolve', () async {
      final syncCompleter = Completer<void>();

      final cubit = MissedRecentCdrsCubit(local, remote, initialSyncDone: syncCompleter.future);
      final future = cubit.init();

      await Future<void>.delayed(const Duration(milliseconds: 10));
      expect(cubit.state.isLoading, isTrue);

      syncCompleter.complete();
      await future;

      expect(cubit.state.isLoading, isFalse);
      await cubit.close();
    });
  });
}
