import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

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
    final existingPort = IsolateNameServer.lookupPortByName(kDbPortName);
    if (existingPort != null) {
      Logger.root.warning('IsolateDatabase.spawnServer - warning: existing for "$kDbPortName" during server startup');
      final isolate = DriftIsolate.fromConnectPort(existingPort);
      // Attempt to shutdown the existing isolate gracefully in case it's a stale instance
      // Note: Already dead in debug mode restart
      if (!kDebugMode) {
        await isolate
            .shutdownAll()
            .timeout(const Duration(seconds: 5))
            .catchError((e, s) {
              Logger.root.warning('IsolateDatabase.spawnServer - failed to shutdown existing isolate', e, s);
            })
            .then((_) {
              Logger.root.info('IsolateDatabase.spawnServer - shutdown of existing isolate completed');
            });
      }

      final removed = IsolateNameServer.removePortNameMapping(kDbPortName);
      Logger.root.info('IsolateDatabase.spawnServer - removed existing port mapping: $removed');
    }

    final receivePort = ReceivePort();
    final errorPort = ReceivePort();
    final exitPort = ReceivePort();

    final completer = Completer<SendPort>();

    final receiveSub = receivePort.listen((message) {
      if (!completer.isCompleted) completer.complete(message as SendPort);
    });

    final errorSub = errorPort.listen((message) {
      if (completer.isCompleted) return;
      final error = message is List ? message[0] : message;
      final rawStack = message is List && message.length > 1 ? message[1] : null;
      final stackTrace = rawStack is String ? StackTrace.fromString(rawStack) : StackTrace.current;
      completer.completeError(DatabaseInitializationException('Database isolate error: $error', stackTrace));
    });

    final exitSub = exitPort.listen((_) {
      if (!completer.isCompleted) {
        completer.completeError(
          DatabaseInitializationException('Database isolate exited before sending connect port', StackTrace.current),
        );
      }
    });

    final isolate = await Isolate.spawn(
      _driftServerEntryPoint,
      [receivePort.sendPort, directoryPath, dbName, EnvironmentConfig.DATABASE_LOG_STATEMENTS],
      onError: errorPort.sendPort,
      onExit: exitPort.sendPort,
    );

    SendPort connectPort;
    try {
      connectPort = await completer.future.timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          isolate.kill(priority: Isolate.immediate);
          throw DatabaseInitializationException('Timed out waiting for database isolate to start', StackTrace.current);
        },
      );
    } finally {
      await receiveSub.cancel();
      await errorSub.cancel();
      await exitSub.cancel();
      receivePort.close();
      errorPort.close();
      exitPort.close();
    }

    final registered = IsolateNameServer.registerPortWithName(connectPort, kDbPortName);
    Logger.root.info('IsolateDatabase.spawnServer - registered port with name "$kDbPortName": $registered');
    if (!registered) {
      throw DatabaseInitializationException(
        'Failed to register DriftIsolate SendPort under "$kDbPortName"',
        StackTrace.current,
      );
    }
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
      Logger.root.info('IsolateDatabase.connectOrCreate: sendPort found, connecting to DriftIsolate server');
      try {
        final driftIsolate = DriftIsolate.fromConnectPort(sendPort);
        return AppDatabase(await driftIsolate.connect());
      } catch (e, s) {
        Logger.root.severe(
          'IsolateDatabase.connectOrCreate: failed to connect, falling back to direct connection',
          e,
          s,
        );
        // Stale port (e.g. after hot reload or app restart) — remove mapping and fall through to direct connection.
        IsolateNameServer.removePortNameMapping(kDbPortName);
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
      Logger.root.info('IsolateDatabase.create - created direct database connection');
      return AppDatabase(executor);
    } catch (e, stackTrace) {
      Logger.root.severe('IsolateDatabase.create - failed to initialize database', e, stackTrace);
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
