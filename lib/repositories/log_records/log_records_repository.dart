import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

import 'package:webtrit_phone/common/disposable.dart';

abstract class LogRecordsRepository {
  Future<void> attachToLogger(Logger logger);

  Future<void> clear();

  Future<void> log(LogRecord record);

  Future<void> dispose();

  Future<void> cancelSubscriptions();

  Future<List<String>> getLogRecords();

  /// Factory that returns concrete implementation depending on [useFileStorage].
  static LogRecordsRepository create({
    required bool useFileStorage,
    required String logFilePath,
    int memoryCapacity = 1000,
  }) {
    if (useFileStorage) {
      return LogRecordsFileRepositoryImpl(logFilePath);
    } else {
      return LogRecordsMemoryRepositoryImpl(memoryCapacity);
    }
  }
}

class LogRecordsMemoryRepositoryImpl implements LogRecordsRepository {
  LogRecordsMemoryRepositoryImpl([this.capacity = 1000]) : _logRecords = ListQueue<LogRecord>(capacity);

  final int capacity;

  final _subscriptions = <StreamSubscription<dynamic>>[];

  final ListQueue<LogRecord> _logRecords;

  @override
  Future<List<String>> getLogRecords() async =>
      UnmodifiableListView(_logRecords.map((it) => DefaultLogRecordFormatter().format(it)));

  @override
  Future<void> attachToLogger(Logger logger) async {
    _subscriptions.add(logger.onRecord.listen(log));
  }

  @override
  Future<void> clear() async {
    _logRecords.clear();
  }

  @override
  Future<void> log(LogRecord record) async {
    if (_logRecords.length >= capacity) {
      _logRecords.removeLast();
    }
    _logRecords.addFirst(record);
  }

  @override
  @mustCallSuper
  Future<void> dispose() async {
    await cancelSubscriptions();
  }

  @override
  Future<void> cancelSubscriptions() async {
    final futures = _subscriptions.map((sub) => sub.cancel()).toList(growable: false);
    _subscriptions.clear();
    await Future.wait<dynamic>(futures);
  }
}

class LogRecordsFileRepositoryImpl implements LogRecordsRepository, Disposable {
  LogRecordsFileRepositoryImpl(String logFilePath)
    : appender = ReadableRotatingFileAppender(
        baseFilePath: logFilePath,
        keepRotateCount: 1,
        formatter: DefaultLogRecordFormatter(),
      );

  final ReadableRotatingFileAppender appender;

  @override
  Future<List<String>> getLogRecords() async => appender.readAllLogs();

  @override
  Future<void> attachToLogger(Logger logger) async => appender.attachToLogger(logger);

  @override
  Future<void> clear() {
    return appender.cleanLogs();
  }

  @override
  Future<void> log(LogRecord record) async {}

  @override
  @mustCallSuper
  Future<void> dispose() => appender.dispose();

  @override
  Future<void> cancelSubscriptions() async {}
}

class ReadableRotatingFileAppender extends RotatingFileAppender {
  ReadableRotatingFileAppender({
    super.formatter,
    required super.baseFilePath,
    super.keepRotateCount,
    super.rotateAtSizeBytes,
    super.rotateCheckInterval,
    super.clock,
  });

  /// Reads logs from all log files, starting from the newest file,
  /// up to the specified [limit] of records.
  ///
  /// Logs are returned as a list of formatted strings.
  Future<List<String>> readAllLogs({int? limit}) async {
    final records = <String>[];

    try {
      // ignore: invalid_use_of_visible_for_testing_member
      await forceFlush();
    } catch (e, st) {
      if (kDebugMode) {
        debugPrint('Error during forceFlush before reading logs: $e\n$st');
      }
    }

    // _getAllLogFilesAsync returns files ordered rotation-0 first (newest write target),
    // so iterating in order reads the newest file first.
    final files = await _getAllLogFilesAsync();

    for (final file in files) {
      try {
        // Use readAsLines for simplicity, which is fine for moderately sized logs.
        // For extremely large logs, a streaming approach (using file.openRead)
        // would be necessary but is significantly more complex to implement
        // while respecting the 'newest first' order.
        final lines = await file.readAsLines();

        // Iterate through lines in reverse (newest line in file first)
        for (final line in lines.reversed) {
          if (limit != null && records.length >= limit) {
            return records; // Stop reading once limit is reached
          }

          final trimmedLine = line.trim();
          if (trimmedLine.isEmpty) continue;

          // Note: The inner try-catch from the original was removed as
          // adding a String to a List<String> does not throw an error.
          records.add(trimmedLine);
        }
      } catch (e, st) {
        // Log the file access error itself without adding it to the log records list
        if (kDebugMode) {
          debugPrint('Error when reading log file: ${file.path}');
          debugPrint('Error: $e\nStackTrace: $st');
        }
      }
    }

    return records;
  }

  /// Returns all existing log files using async [File.exists] checks.
  ///
  /// [getAllLogFiles] from the parent class uses [File.existsSync] which may
  /// return stale results immediately after [forceFlush] due to OS filesystem
  /// cache. Using async [File.exists] forces a fresh stat() call per file.
  ///
  /// Covers the full rotation range (0..keepRotateCount inclusive) because
  /// [RotatingFileAppender._maybeRotate] renames file[keepRotateCount-1] to
  /// file[keepRotateCount], so the base file may be absent right after rotation
  /// while file[keepRotateCount] still holds recent logs.
  Future<List<File>> _getAllLogFilesAsync() async {
    final result = <File>[];
    for (int rotation = 0; rotation <= keepRotateCount; rotation++) {
      final path = rotation == 0 ? baseFilePath : '$baseFilePath.$rotation';
      final file = File(path);
      if (await file.exists()) {
        result.add(file);
      }
    }
    return result;
  }

  /// Deletes all log files (base file and rotated files).
  Future<void> cleanLogs() async {
    try {
      // ignore: invalid_use_of_visible_for_testing_member
      await forceFlush();
    } catch (e, st) {
      if (kDebugMode) {
        debugPrint('Error during forceFlush before cleaning logs: $e\n$st');
      }
    }

    // Get all rotated files (e.g. app.log, app.log.1, app.log.2)
    final files = await _getAllLogFilesAsync();

    for (final file in files) {
      try {
        if (await file.exists()) {
          await file.delete();
        }
      } catch (e) {
        // We print directly to console/stderr here because we shouldn't
        // try to log to the file system we are currently destroying.
        if (kDebugMode) {
          print('Error deleting log file ${file.path}: $e');
        }
      }
    }
  }
}
