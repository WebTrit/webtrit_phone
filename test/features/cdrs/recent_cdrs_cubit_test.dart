import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/cdrs/cdrs.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class MockCdrsLocalRepository extends Mock implements CdrsLocalRepository {}

class MockCdrsRemoteRepository extends Mock implements CdrsRemoteRepository {}

CdrRecord _record(String id, {CdrStatus status = CdrStatus.accepted}) => CdrRecord(
  callId: id,
  direction: CallDirection.incoming,
  status: status,
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
  late StreamController<CdrRecordsEvent> events;

  setUp(() {
    local = MockCdrsLocalRepository();
    remote = MockCdrsRemoteRepository();
    events = StreamController<CdrRecordsEvent>.broadcast();

    when(() => local.events).thenAnswer((_) => events.stream);
    when(() => local.getLastSyncTime()).thenAnswer((_) async => null);
  });

  tearDown(() => events.close());

  group('FullRecentCdrsCubit.init', () {
    test('empty cache without a sync cursor stays loading until the sync completes', () async {
      var call = 0;
      when(() => local.getHistory(limit: any(named: 'limit'))).thenAnswer((_) async {
        call++;
        return call == 1 ? <CdrRecord>[] : [_record('a')];
      });

      final cubit = FullRecentCdrsCubit(local, remote);
      await cubit.init();

      expect(cubit.state.isLoading, isTrue);

      events.add(CdrsInitialSyncCompleted());
      await Future<void>.delayed(const Duration(milliseconds: 10));

      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.records, [_record('a')]);
      await cubit.close();
    });

    test('empty cache with an existing sync cursor resolves to the empty state immediately', () async {
      when(() => local.getLastSyncTime()).thenAnswer((_) async => DateTime(2026, 1, 1));
      when(() => local.getHistory(limit: any(named: 'limit'))).thenAnswer((_) async => <CdrRecord>[]);

      final cubit = FullRecentCdrsCubit(local, remote);
      await cubit.init();

      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.records, isEmpty);
      await cubit.close();
    });

    test('non-empty cache resolves immediately regardless of the sync cursor', () async {
      when(() => local.getHistory(limit: any(named: 'limit'))).thenAnswer((_) async => [_record('a')]);

      final cubit = FullRecentCdrsCubit(local, remote);
      await cubit.init();

      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.records, [_record('a')]);
      await cubit.close();
    });

    test('an upsert event resolves loading even before the sync-completed event', () async {
      when(() => local.getHistory(limit: any(named: 'limit'))).thenAnswer((_) async => <CdrRecord>[]);

      final cubit = FullRecentCdrsCubit(local, remote);
      await cubit.init();
      expect(cubit.state.isLoading, isTrue);

      events.add(CdrRecordUpserted(_record('a')));
      await Future<void>.delayed(const Duration(milliseconds: 10));

      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.records, [_record('a')]);
      await cubit.close();
    });

    test('cursor written between the read and the subscription is not missed', () async {
      // First cursor read (gate) returns null, second (race re-check) returns a value.
      var cursorCall = 0;
      when(() => local.getLastSyncTime()).thenAnswer((_) async {
        cursorCall++;
        return cursorCall == 1 ? null : DateTime(2026, 1, 1);
      });
      when(() => local.getHistory(limit: any(named: 'limit'))).thenAnswer((_) async => <CdrRecord>[]);

      final cubit = FullRecentCdrsCubit(local, remote);
      await cubit.init();

      expect(cubit.state.isLoading, isFalse);
      await cubit.close();
    });

    test('a failed initial sync resolves loading to the empty state instead of spinning forever', () async {
      when(() => local.getHistory(limit: any(named: 'limit'))).thenAnswer((_) async => <CdrRecord>[]);

      final cubit = FullRecentCdrsCubit(local, remote);
      await cubit.init();
      expect(cubit.state.isLoading, isTrue);

      events.add(CdrsInitialSyncFailed());
      await Future<void>.delayed(const Duration(milliseconds: 10));

      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.records, isEmpty);
      await cubit.close();
    });

    test('a sync success after an earlier failure still populates the list', () async {
      when(() => local.getHistory(limit: any(named: 'limit'))).thenAnswer((_) async => <CdrRecord>[]);

      final cubit = FullRecentCdrsCubit(local, remote);
      await cubit.init();

      events.add(CdrsInitialSyncFailed());
      await Future<void>.delayed(const Duration(milliseconds: 10));
      expect(cubit.state.isLoading, isFalse);

      // The next successful cycle delivers records via the usual upsert events.
      events.add(CdrRecordUpserted(_record('a')));
      await Future<void>.delayed(const Duration(milliseconds: 10));

      expect(cubit.state.records, [_record('a')]);
      await cubit.close();
    });

    test('a cache wipe drops the records and re-arms the loading gate until the next sync', () async {
      when(() => local.getLastSyncTime()).thenAnswer((_) async => DateTime(2026, 1, 1));
      var call = 0;
      when(() => local.getHistory(limit: any(named: 'limit'))).thenAnswer((_) async {
        call++;
        return call == 1 ? [_record('a')] : <CdrRecord>[];
      });

      final cubit = FullRecentCdrsCubit(local, remote);
      await cubit.init();
      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.records, [_record('a')]);

      events.add(CdrRecordsWiped());
      await Future<void>.delayed(const Duration(milliseconds: 10));

      expect(cubit.state.records, isEmpty);
      expect(cubit.state.isLoading, isTrue);

      // The wiped cursor is rewritten by the next successful sync cycle,
      // which resolves the gate with the fresh (here: empty) state.
      events.add(CdrsInitialSyncCompleted());
      await Future<void>.delayed(const Duration(milliseconds: 10));

      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.records, isEmpty);
      await cubit.close();
    });

    test('closing the cubit while init is still in flight neither throws nor emits', () async {
      when(() => local.getHistory(limit: any(named: 'limit'))).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 20));
        return <CdrRecord>[];
      });

      final cubit = FullRecentCdrsCubit(local, remote);
      final initFuture = cubit.init();
      await cubit.close();

      // Must complete without StateError (emit after close) or
      // LateInitializationError (cancelling a never-assigned subscription).
      await initFuture;
      expect(cubit.state.isLoading, isTrue); // no emit happened after close
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

    test('empty cache without a sync cursor stays loading until the sync completes and the scan runs', () async {
      final cubit = MissedRecentCdrsCubit(local, remote);
      await cubit.init();

      expect(cubit.state.isLoading, isTrue);

      events.add(CdrsInitialSyncCompleted());
      await Future<void>.delayed(const Duration(milliseconds: 10));

      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.records, isEmpty);
      await cubit.close();
    });

    test('empty cache with an existing sync cursor resolves and scans immediately', () async {
      when(() => local.getLastSyncTime()).thenAnswer((_) async => DateTime(2026, 1, 1));

      final cubit = MissedRecentCdrsCubit(local, remote);
      await cubit.init();

      expect(cubit.state.isLoading, isFalse);
      // Let the fire-and-forget remote scan settle before closing the cubit.
      await Future<void>.delayed(const Duration(milliseconds: 10));
      await cubit.close();
    });

    test('a missed-call upsert resolves loading before the sync-completed event', () async {
      final cubit = MissedRecentCdrsCubit(local, remote);
      await cubit.init();
      expect(cubit.state.isLoading, isTrue);

      events.add(CdrRecordUpserted(_record('a', status: CdrStatus.missed)));
      await Future<void>.delayed(const Duration(milliseconds: 10));

      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.records, [_record('a', status: CdrStatus.missed)]);
      await cubit.close();
    });

    test('a failed initial sync resolves loading; a later success still runs the scan', () async {
      final cubit = MissedRecentCdrsCubit(local, remote);
      await cubit.init();
      expect(cubit.state.isLoading, isTrue);

      events.add(CdrsInitialSyncFailed());
      await Future<void>.delayed(const Duration(milliseconds: 10));

      // Failure resolves the endless spinner into the empty state...
      expect(cubit.state.isLoading, isFalse);
      verifyNever(
        () => remote.getHistory(
          to: any(named: 'to'),
          limit: any(named: 'limit'),
        ),
      );

      // ...but nothing is persisted, so the eventual success still triggers
      // the one-shot missed-calls scan.
      events.add(CdrsInitialSyncCompleted());
      await Future<void>.delayed(const Duration(milliseconds: 10));

      verify(
        () => remote.getHistory(
          to: any(named: 'to'),
          limit: any(named: 'limit'),
        ),
      ).called(greaterThan(0));
      await cubit.close();
    });
  });

  group('NumberCdrsLogCubit.init', () {
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

    test('empty cache without a sync cursor stays loading until the sync completes and the scan runs', () async {
      final cubit = NumberCdrsLogCubit('2000', local, remote);
      await cubit.init();

      expect(cubit.state.isLoading, isTrue);

      events.add(CdrsInitialSyncCompleted());
      await Future<void>.delayed(const Duration(milliseconds: 10));

      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.records, isEmpty);
      await cubit.close();
    });
  });
}
