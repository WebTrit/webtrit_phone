import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

class RemoteFormatter extends LogRecordFormatter {
  const RemoteFormatter();

  @override
  StringBuffer formatToStringBuffer(LogRecord rec, StringBuffer sb) {
    sb.write(rec.message);

    void formatErrorAndStackTrace(final Object? error, StackTrace? stackTrace) {
      if (error != null) {
        sb.writeln();
        sb.write('### ${error.runtimeType}: ');
        sb.write(error);
      }
      // ignore: avoid_as
      final stack = stackTrace ?? (error is Error ? (error).stackTrace : null);
      if (stack != null) {
        sb.writeln();
        sb.write(stack);
      }
      final causedBy =
          DefaultLogRecordFormatter.causedByFetchers.map((e) => e(error)).where((x) => x != null).firstOrNull;
      if (causedBy != null) {
        sb.write('### Caused by: ');
        formatErrorAndStackTrace(causedBy.error, causedBy.stack);
      }
    }

    formatErrorAndStackTrace(rec.error, rec.stackTrace);

    return sb;
  }
}
