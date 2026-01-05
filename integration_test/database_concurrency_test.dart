import 'dart:math';

import 'package:flutter/foundation.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:webtrit_phone/common/db/isolate_database.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/call_logs/call_logs_repository.dart';

import 'components/database_file_helper.dart';
import 'components/fake_app_path.dart';
import 'models/models.dart';

const _targetNumber = 'SHARED-NUMBER';

/// Integration tests for Database Concurrency & Locking.
///
/// These tests verify that the SQLite configuration (specifically WAL mode and busy_timeout)
/// correctly handles simultaneous read/write operations from multiple isolates
/// (Main UI Isolate and Background Isolate).
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late FakeAppPath fakeAppPath;

  group('Database Concurrency & Locking Tests', () {
    late String dbPath;
    late String dbName;
    late AppDatabase mainDb;
    late CallLogsRepository mainRepository;

    setUp(() async {
      fakeAppPath = FakeAppPath();
      dbPath = fakeAppPath.applicationDocumentsPath;
      dbName = 'test_db.sqlite';

      // Ensure a fresh state for each test
      await DatabaseFileHelper.deleteDatabaseFiles(directoryPath: dbPath, dbName: dbName);

      mainDb = IsolateDatabase.create(directoryPath: dbPath, dbName: dbName);
      mainRepository = CallLogsRepository(appDatabase: mainDb);
    });

    tearDown(() async {
      await mainDb.close();
      await DatabaseFileHelper.deleteDatabaseFiles(directoryPath: dbPath, dbName: dbName);
      fakeAppPath.cleanup();
    });

    testWidgets(
      'Should maintain consistency under heavy balanced load (50 BG / 50 UI)',
      (tester) => _executeConcurrencyTest(dbPath, dbName, mainRepository, bgCount: 50, uiCount: 50),
    );

    testWidgets(
      'Should maintain consistency with heavy background bias (50 BG / 25 UI)',
      (tester) => _executeConcurrencyTest(dbPath, dbName, mainRepository, bgCount: 50, uiCount: 25),
    );

    testWidgets(
      'Should reflect background writes in UI isolate immediately (20 BG / 0 UI)',
      (tester) => _executeConcurrencyTest(dbPath, dbName, mainRepository, bgCount: 20, uiCount: 0),
    );

    testWidgets(
      'Should maintain consistency under moderate balanced load (30 BG / 30 UI)',
      (tester) => _executeConcurrencyTest(dbPath, dbName, mainRepository, bgCount: 30, uiCount: 30),
    );

    testWidgets(
      'Should maintain consistency with heavy UI bias (15 BG / 30 UI)',
      (tester) => _executeConcurrencyTest(dbPath, dbName, mainRepository, bgCount: 15, uiCount: 30),
    );

    testWidgets(
      'Should handle UI-only writes without locking issues (0 BG / 30 UI)',
      (tester) => _executeConcurrencyTest(dbPath, dbName, mainRepository, bgCount: 0, uiCount: 30),
    );

    testWidgets(
      'Should handle zero-write scenario gracefully (0 BG / 0 UI)',
      (tester) => _executeConcurrencyTest(dbPath, dbName, mainRepository, bgCount: 0, uiCount: 0),
    );
  });
}

/// Orchestrates the concurrency test scenario.
Future<void> _executeConcurrencyTest(
  String dbPath,
  String dbName,
  CallLogsRepository mainRepository, {
  required int bgCount,
  required int uiCount,
}) async {
  // Start Background Task (non-blocking)
  final bgFuture = compute(
    _runBackgroundWrites,
    ConcurrencyWorkerArgs(dbPath: dbPath, dbName: dbName, itemsToWrite: bgCount),
  );
  // Perform UI Writes
  final uiFuture = _performBatchWrites(mainRepository, count: uiCount);

  final bgSuccess = await bgFuture;
  final uiSuccess = await uiFuture;

  final logs = await mainRepository.watchHistoryByNumber(_targetNumber).first;

  expect(uiSuccess, equals(uiCount), reason: 'UI writes mismatch');
  expect(bgSuccess, equals(bgCount), reason: 'BG writes mismatch');
  expect(logs.length, equals(bgCount + uiCount), reason: 'Total DB rows mismatch');
}

/// Entry point for the background isolate.
///
/// Establishes an independent DB connection and executes the write batch.
Future<int> _runBackgroundWrites(ConcurrencyWorkerArgs config) async {
  final db = IsolateDatabase.create(directoryPath: config.dbPath, dbName: config.dbName);
  final repository = CallLogsRepository(appDatabase: db);

  try {
    return await _performBatchWrites(repository, count: config.itemsToWrite);
  } catch (e) {
    debugPrint('Background Isolate Error: $e');
    rethrow;
  } finally {
    await db.close();
  }
}

/// Shared logic to write a batch of records with random delays.
Future<int> _performBatchWrites(CallLogsRepository repository, {required int count}) async {
  final random = Random();
  int successCount = 0;

  for (var i = 0; i < count; i++) {
    final call = CallLogsFixtureFactory.createCall(i, _targetNumber);
    await repository.add(call);
    successCount++;

    await Future.delayed(Duration(milliseconds: random.nextInt(5)));
  }
  return successCount;
}
