import 'dart:developer';

import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

class DeveloperLogAppender extends BaseLogAppender {
  DeveloperLogAppender({LogRecordFormatter? formatter}) : super(formatter ?? const DefaultLogRecordFormatter());

  /// Will setup the root logger with the given level and appends
  /// a new PrintAppender to it.
  ///
  /// Will also remove all previously registered listeners on the root logger.
  ///
  /// If [stderrLevel] is set in dart:io, will log everything at and above
  /// this level to stderr instead of stdout.
  static DeveloperLogAppender setupLogging({Level level = Level.ALL}) {
    Logger.root.clearListeners();
    Logger.root.level = level;
    return DeveloperLogAppender()..attachToLogger(Logger.root);
  }

  @override
  void handle(LogRecord record) {
    log(
      record.message,
      time: record.time,
      sequenceNumber: record.sequenceNumber,
      level: record.level.value,
      name: record.loggerName,
      zone: record.zone,
      error: record.error,
      stackTrace: record.stackTrace,
    );
  }
}
