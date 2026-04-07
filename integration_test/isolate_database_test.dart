import 'dart:isolate';
import 'dart:ui';

import 'package:drift/isolate.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:webtrit_phone/common/db/isolate_database.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/call_logs/call_logs_repository.dart';

import 'components/components.dart';

const _dbName = 'test_isolate_db.sqlite';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late FakeAppPath fakeAppPath;
  late String dbPath;

  setUp(() async {
    fakeAppPath = FakeAppPath();
    dbPath = fakeAppPath.applicationDocumentsPath;
    await DatabaseFileHelper.deleteDatabaseFiles(directoryPath: dbPath, dbName: _dbName);
    IsolateNameServer.removePortNameMapping(IsolateDatabase.kDbPortName);
  });

  tearDown(() async {
    IsolateNameServer.removePortNameMapping(IsolateDatabase.kDbPortName);
    await DatabaseFileHelper.deleteDatabaseFiles(directoryPath: dbPath, dbName: _dbName);
    fakeAppPath.cleanup();
  });

  group('IsolateDatabase.connectOrCreate', () {
    testWidgets('falls back to direct connection when no port is registered', (tester) async {
      expect(IsolateNameServer.lookupPortByName(IsolateDatabase.kDbPortName), isNull);

      final db = await IsolateDatabase.connectOrCreate(directoryPath: dbPath, dbName: _dbName);
      final repo = CallLogsRepository(appDatabase: db);
      final logs = await repo.watchHistoryByNumber('any').first;
      await db.close();

      expect(logs, isEmpty);
    });

    testWidgets('removes stale port mapping after failed connect and falls back to direct connection', (tester) async {
      final stalePort = ReceivePort();
      IsolateNameServer.registerPortWithName(stalePort.sendPort, IsolateDatabase.kDbPortName);

      final db = await IsolateDatabase.connectOrCreate(directoryPath: dbPath, dbName: _dbName);
      await db.close();
      stalePort.close();

      expect(IsolateNameServer.lookupPortByName(IsolateDatabase.kDbPortName), isNull);
    });
  });

  group('IsolateDatabase.spawnServer', () {
    testWidgets('registers port in IsolateNameServer and client connection is functional', (tester) async {
      DriftIsolate? server;
      AppDatabase? db;
      try {
        server = await IsolateDatabase.spawnServer(directoryPath: dbPath, dbName: _dbName);

        expect(IsolateNameServer.lookupPortByName(IsolateDatabase.kDbPortName), isNotNull);

        db = AppDatabase(await server.connect());
        final repo = CallLogsRepository(appDatabase: db);
        final logs = await repo.watchHistoryByNumber('any').first;
        expect(logs, isEmpty);
      } finally {
        await db?.close();
        await server?.shutdownAll();
      }
    });

    testWidgets('replaces stale port mapping before registering the new server', (tester) async {
      final stalePort = ReceivePort();
      IsolateNameServer.registerPortWithName(stalePort.sendPort, IsolateDatabase.kDbPortName);

      DriftIsolate? server;
      AppDatabase? db;
      try {
        server = await IsolateDatabase.spawnServer(directoryPath: dbPath, dbName: _dbName);

        final registeredPort = IsolateNameServer.lookupPortByName(IsolateDatabase.kDbPortName);
        expect(registeredPort, isNotNull);
        expect(registeredPort, isNot(same(stalePort.sendPort)));

        db = AppDatabase(await server.connect());
        await db.close();
        db = null;
      } finally {
        stalePort.close();
        await db?.close();
        await server?.shutdownAll();
      }
    });
  });
}
