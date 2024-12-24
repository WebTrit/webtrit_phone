import 'package:logging/logging.dart';
import 'package:dio/dio.dart' show DioException, DioExceptionType;

class RemoteLogFilter {
  static const List<String> ignoredHosts = [
    'listener.logz.io',
  ];

  static bool shouldLog(LogRecord record) {
    if (record.error == null) return true;

    if (record.error is! DioException) return true;

    final dioError = record.error as DioException;

    // Skip adding spam logs to the buffer if there is no internet connection for the specified hosts
    if ((dioError.type == DioExceptionType.connectionTimeout || dioError.type == DioExceptionType.connectionError) &&
        ignoredHosts.any((host) => dioError.toString().contains(host))) {
      return false;
    }

    return true;
  }
}
