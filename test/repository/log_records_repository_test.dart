import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/repositories/log_records/log_records_repository.dart';

void main() {
  Logger.root.level = Level.ALL;

  // ---------------------------------------------------------------------------
  // LogRecordsMemoryRepositoryImpl
  // ---------------------------------------------------------------------------

  group('LogRecordsMemoryRepositoryImpl', () {
    late LogRecordsMemoryRepositoryImpl repo;

    setUp(() => repo = LogRecordsMemoryRepositoryImpl());
    tearDown(() async => repo.dispose());

    test('returns empty list when no records logged', () async {
      expect(await repo.getLogRecords(), isEmpty);
    });

    test('log adds record and getLogRecords returns it', () async {
      await repo.log(LogRecord(Level.INFO, 'hello', 'test'));

      final records = await repo.getLogRecords();
      expect(records, hasLength(1));
      expect(records.first, contains('hello'));
    });

    test('records returned newest first', () async {
      await repo.log(LogRecord(Level.INFO, 'first', 'test'));
      await repo.log(LogRecord(Level.INFO, 'second', 'test'));
      await repo.log(LogRecord(Level.INFO, 'third', 'test'));

      final records = await repo.getLogRecords();
      expect(records[0], contains('third'));
      expect(records[1], contains('second'));
      expect(records[2], contains('first'));
    });

    test('capacity evicts oldest record when exceeded', () async {
      final small = LogRecordsMemoryRepositoryImpl(3);
      await small.log(LogRecord(Level.INFO, 'oldest', 'test'));
      await small.log(LogRecord(Level.INFO, 'middle', 'test'));
      await small.log(LogRecord(Level.INFO, 'newest', 'test'));
      await small.log(LogRecord(Level.INFO, 'overflow', 'test'));

      final records = await small.getLogRecords();
      expect(records, hasLength(3));
      expect(records.any((r) => r.contains('oldest')), isFalse);
      expect(records.any((r) => r.contains('overflow')), isTrue);
      await small.dispose();
    });

    test('clear empties the record queue', () async {
      await repo.log(LogRecord(Level.INFO, 'msg', 'test'));
      await repo.clear();

      expect(await repo.getLogRecords(), isEmpty);
    });

    test('attachToLogger captures records emitted by Logger', () async {
      final logger = Logger('test.attach');
      await repo.attachToLogger(logger);

      logger.info('from logger');

      final records = await repo.getLogRecords();
      expect(records, hasLength(1));
      expect(records.first, contains('from logger'));
    });

    test('cancelSubscriptions stops capturing new records', () async {
      final logger = Logger('test.cancel');
      await repo.attachToLogger(logger);
      await repo.cancelSubscriptions();

      logger.info('after cancel');

      expect(await repo.getLogRecords(), isEmpty);
    });

    test('dispose calls cancelSubscriptions — no records after dispose', () async {
      final logger = Logger('test.dispose');
      await repo.attachToLogger(logger);
      await repo.dispose();

      logger.info('after dispose');

      expect(await repo.getLogRecords(), isEmpty);
    });
  });

  // ---------------------------------------------------------------------------
  // ReadableRotatingFileAppender
  // ---------------------------------------------------------------------------

  group('ReadableRotatingFileAppender', () {
    late Directory tempDir;
    late String basePath;
    late ReadableRotatingFileAppender appender;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('log_records_test_');
      basePath = '${tempDir.path}/app.log';
      appender = ReadableRotatingFileAppender(baseFilePath: basePath, keepRotateCount: 1);
    });

    tearDown(() async {
      await appender.dispose();
      if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
    });

    // -------------------------------------------------------------------------
    // readAllLogs
    // -------------------------------------------------------------------------

    group('readAllLogs', () {
      test('returns empty list when no log files exist', () async {
        expect(await appender.readAllLogs(), isEmpty);
      });

      test('reads lines from base file, newest line first', () async {
        File(basePath).writeAsStringSync('line-1\nline-2\nline-3\n');

        final records = await appender.readAllLogs();
        expect(records, ['line-3', 'line-2', 'line-1']);
      });

      test('skips blank lines', () async {
        File(basePath).writeAsStringSync('line-1\n\nline-2\n\n');

        final records = await appender.readAllLogs();
        expect(records, ['line-2', 'line-1']);
      });

      test('reads base file then rotated file, newest first', () async {
        File(basePath).writeAsStringSync('new-1\nnew-2\n');
        File('$basePath.1').writeAsStringSync('old-1\nold-2\n');

        // Base file contains newer logs, so its lines appear before rotated file lines (overall newest first).
        final records = await appender.readAllLogs();
        expect(records, ['new-2', 'new-1', 'old-2', 'old-1']);
      });

      test('reads only rotated file when base file is absent (post-rotation state)', () async {
        File('$basePath.1').writeAsStringSync('old-1\nold-2\n');

        final records = await appender.readAllLogs();
        expect(records, ['old-2', 'old-1']);
      });

      test('respects limit parameter', () async {
        File(basePath).writeAsStringSync('a\nb\nc\nd\ne\n');

        final records = await appender.readAllLogs(limit: 3);
        expect(records, hasLength(3));
        expect(records, ['e', 'd', 'c']);
      });

      test('limit spanning two files stops early', () async {
        File(basePath).writeAsStringSync('new-1\nnew-2\nnew-3\n');
        File('$basePath.1').writeAsStringSync('old-1\nold-2\nold-3\n');

        final records = await appender.readAllLogs(limit: 4);
        expect(records, hasLength(4));
        expect(records, ['new-3', 'new-2', 'new-1', 'old-3']);
      });

      test('returns all records when limit exceeds total line count', () async {
        File(basePath).writeAsStringSync('a\nb\n');

        final records = await appender.readAllLogs(limit: 100);
        expect(records, hasLength(2));
      });
    });

    // -------------------------------------------------------------------------
    // cleanLogs
    // -------------------------------------------------------------------------

    group('cleanLogs', () {
      test('deletes base file when it exists', () async {
        File(basePath).writeAsStringSync('data');

        await appender.cleanLogs();

        expect(File(basePath).existsSync(), isFalse);
      });

      test('deletes rotated file when it exists', () async {
        File('$basePath.1').writeAsStringSync('data');

        await appender.cleanLogs();

        expect(File('$basePath.1').existsSync(), isFalse);
      });

      test('deletes both files when both exist', () async {
        File(basePath).writeAsStringSync('new');
        File('$basePath.1').writeAsStringSync('old');

        await appender.cleanLogs();

        expect(File(basePath).existsSync(), isFalse);
        expect(File('$basePath.1').existsSync(), isFalse);
      });

      test('does not throw when no files exist', () async {
        await expectLater(appender.cleanLogs(), completes);
      });

      test('after cleanLogs readAllLogs returns empty list', () async {
        File(basePath).writeAsStringSync('some logs');
        File('$basePath.1').writeAsStringSync('old logs');

        await appender.cleanLogs();

        expect(await appender.readAllLogs(), isEmpty);
      });

      test('cleans only rotated file in post-rotation state', () async {
        File('$basePath.1').writeAsStringSync('rotated logs');

        await appender.cleanLogs();

        expect(File('$basePath.1').existsSync(), isFalse);
      });
    });
  });

  // ---------------------------------------------------------------------------
  // LogRecordsFileRepositoryImpl
  // ---------------------------------------------------------------------------

  group('LogRecordsFileRepositoryImpl', () {
    late Directory tempDir;
    late LogRecordsFileRepositoryImpl repo;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('log_records_file_test_');
      repo = LogRecordsFileRepositoryImpl(tempDir.path);
    });

    tearDown(() async {
      await repo.dispose();
      if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
    });

    test('getLogRecords returns empty list when no files exist', () async {
      expect(await repo.getLogRecords(), isEmpty);
    });

    test('getLogRecords returns records from existing log file', () async {
      File('${tempDir.path}/app_logs.log').writeAsStringSync('line-a\nline-b\n');

      final records = await repo.getLogRecords();
      expect(records, ['line-b', 'line-a']);
    });

    test('clear deletes log files', () async {
      File('${tempDir.path}/app_logs.log').writeAsStringSync('data');

      await repo.clear();

      expect(File('${tempDir.path}/app_logs.log').existsSync(), isFalse);
    });

    test('dispose completes without error', () async {
      await expectLater(repo.dispose(), completes);
    });
  });
}
