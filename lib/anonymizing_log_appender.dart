// import 'package:logging/logging.dart';
// import 'package:logging_appenders/logging_appenders.dart';
//
// class AnonymizingLogAppender extends BaseLogAppender {
//   AnonymizingLogAppender(LogRecordFormatter? formatter) : super(formatter);
//
//   @override
//   void handle(LogRecord record) {
//     final sanitizedMessage = _sanitize(record.message);
//     final sanitizedError = record.error != null ? _sanitize(record.error.toString()) : null;
//     final sanitizedStackTrace = record.stackTrace?.toString();
//
//     // Формуємо новий запис для логування
//     final sanitizedRecord = LogRecord(
//       record.level,
//       sanitizedMessage,
//       record.loggerName,
//       sanitizedError,
//       sanitizedStackTrace != null ? StackTrace.fromString(sanitizedStackTrace) : null,
//       record.zone,
//     );
//
//     // Передаємо відформатоване повідомлення без повторного виклику handle
//     print(formatter!.format(sanitizedRecord));
//   }
//
//   String _sanitize(String input) {
//     return input
//         // Маскування email
//         .replaceAll(RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b'), '[REDACTED_EMAIL]')
//         // Маскування IP-адрес
//         .replaceAll(RegExp(r'\b(?:\d{1,3}\.){3}\d{1,3}\b'), '[REDACTED_IP]')
//         // Маскування телефонних номерів
//         .replaceAll(RegExp(r'\b\d{10,15}\b'), '[REDACTED_PHONE]')
//         // Маскування токенів та інших чутливих строк
//         .replaceAll(RegExp(r'eyJ[a-zA-Z0-9._-]+'), '[REDACTED_TOKEN]');
//   }
// }
