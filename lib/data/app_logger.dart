import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/models/main_flavor.dart';

import 'feature_access.dart';

export 'package:permission_handler/permission_handler.dart' show Permission, PermissionStatus;

class AppLogger {
  static late AppLogger _instance;

  static Future<AppLogger> init({Level? level = null}) async {
    hierarchicalLoggingEnabled = true;

    // Set the logging level
    Logger.root.level = level ?? Level.CONFIG;

    // Use only the AnonymizingLogAppender
    final anonymizingAppender = AnonymizingLogAppender(null);
    anonymizingAppender.attachToLogger(Logger.root);
    _instance = AppLogger._();
    return _instance;
  }

  factory AppLogger() {
    return _instance;
  }

  AppLogger._();

  /// Opens the app settings page.
  Future<bool> toAppSettings() => openAppSettings();
}

class AnonymizingLogAppender extends BaseLogAppender {
  AnonymizingLogAppender(LogRecordFormatter? formatter) : super(formatter);

  @override
  void handle(LogRecord record) {
    final sanitizedMessage = _sanitize(record.message);
    final sanitizedError = record.error != null ? _sanitize(record.error.toString()) : null;
    final sanitizedStackTrace = record.stackTrace?.toString();

    // Формуємо новий запис для логування
    final sanitizedRecord = LogRecord(
      record.level,
      sanitizedMessage,
      record.loggerName,
      sanitizedError,
      sanitizedStackTrace != null ? StackTrace.fromString(sanitizedStackTrace) : null,
      record.zone,
    );

    // Передаємо відформатоване повідомлення без повторного виклику handle
    print(formatter!.format(sanitizedRecord));
  }

  String _sanitize(String input) {
    return input
        // Маскування email
        .replaceAll(RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b'), '[REDACTED_EMAIL]')
        // Маскування IP-адрес
        .replaceAll(RegExp(r'\b(?:\d{1,3}\.){3}\d{1,3}\b'), '[REDACTED_IP]')
        // Маскування телефонних номерів
        .replaceAll(RegExp(r'\b\d{10,15}\b'), '[REDACTED_PHONE]')
        // Маскування токенів та інших чутливих строк
        .replaceAll(RegExp(r'eyJ[a-zA-Z0-9._-]+'), '[REDACTED_TOKEN]');
  }
}
