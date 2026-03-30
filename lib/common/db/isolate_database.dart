import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';

/// The [IsolateNameServer] key under which the [DriftIsolate] server's [SendPort] is registered.
///
/// Used by background isolates (e.g. FCM handler, WorkManager) to connect to the shared
/// database server spawned by the main isolate, eliminating write-write contention.
const _kDbPortName = 'webtrit_app_db';

/// Entry point for the dedicated [DriftIsolate] database server isolate.
///
/// This function is spawned via [Isolate.spawn] and runs in a separate isolate.
/// It creates a synchronous [NativeDatabase], starts a [DriftIsolate] server,
/// and sends back the [SendPort] so that any isolate can connect to it.
@pragma('vm:entry-point')
void _driftServerEntryPoint(List<dynamic> args) {
  final sendPort = args[0] as SendPort;
  final directoryPath = args[1] as String;
  final dbName = args[2] as String;
  final logStatements = args[3] as bool;

  final executor = createAppDatabaseNative(directoryPath, dbName, logStatements: logStatements);

  final server = DriftIsolate.inCurrent(() => DatabaseConnection(executor));
  sendPort.send(server.connectPort);
}

/// Helper for creating [AppDatabase] instances in different isolates.
abstract final class IsolateDatabase {
  /// The [IsolateNameServer] key used to share the [DriftIsolate] [SendPort].
  static const kDbPortName = _kDbPortName;

  /// Spawns a dedicated [DriftIsolate] server isolate that owns the single database
  /// connection for [directoryPath]/[dbName], and registers its [SendPort] in
  /// [IsolateNameServer] under [kDbPortName].
  ///
  /// Call this once from the main isolate (e.g. in [bootstrap]) before [runApp].
  /// All other isolates should use [connectOrCreate] to obtain a client connection.
  static Future<DriftIsolate> spawnServer({required String directoryPath, String dbName = 'db.sqlite'}) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_driftServerEntryPoint, [
      receivePort.sendPort,
      directoryPath,
      dbName,
      EnvironmentConfig.DATABASE_LOG_STATEMENTS,
    ]);
    final connectPort = await receivePort.first as SendPort;
    receivePort.close();
    IsolateNameServer.registerPortWithName(connectPort, kDbPortName);
    return DriftIsolate.fromConnectPort(connectPort);
  }

  /// Connects to the shared [DriftIsolate] server registered in [IsolateNameServer],
  /// or falls back to a direct [NativeDatabase] connection if none is found.
  ///
  /// Use this in isolates that may run concurrently with the main app
  /// (e.g. FCM background handler, WorkManager) instead of [create].
  static Future<AppDatabase> connectOrCreate({required String directoryPath, String dbName = 'db.sqlite'}) async {
    final sendPort = IsolateNameServer.lookupPortByName(kDbPortName);
    if (sendPort != null) {
      try {
        final driftIsolate = DriftIsolate.fromConnectPort(sendPort);
        return AppDatabase(await driftIsolate.connect());
      } catch (_) {
        // Stale port (e.g. after hot reload or app restart) — fall through to direct connection.
      }
    }
    return create(directoryPath: directoryPath, dbName: dbName);
  }

  /// Opens a new direct [AppDatabase] instance for [directoryPath]/[dbName].
  ///
  /// Note: This creates a new SQLite connection each time. Avoid calling it repeatedly in
  /// concurrent code paths; prefer [use] to ensure connections are closed deterministically.
  static AppDatabase create({required String directoryPath, String dbName = 'db.sqlite'}) {
    assert(directoryPath.isNotEmpty, 'directoryPath must not be empty');
    assert(dbName.isNotEmpty, 'dbName must not be empty');

    try {
      final executor = createAppDatabaseConnection(
        directoryPath,
        dbName,
        logStatements: EnvironmentConfig.DATABASE_LOG_STATEMENTS,
      );
      return AppDatabase(executor);
    } catch (e, stackTrace) {
      throw DatabaseInitializationException('Failed to initialize database: $e', stackTrace);
    }
  }
}

class DatabaseInitializationException implements Exception {
  final String message;
  final StackTrace stackTrace;

  DatabaseInitializationException(this.message, this.stackTrace);

  @override
  String toString() => 'DatabaseInitializationException: $message\n$stackTrace';
}
