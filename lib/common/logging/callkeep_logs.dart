import 'package:logging/logging.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

class CallkeepLogs implements CallkeepLogsDelegate {
  final _logger = Logger('CallkeepLogs');

  @override
  void onLog(CallkeepLogType type, String tag, String message) {
    final formattedMessage = '[$tag] $message';

    switch (type) {
      case CallkeepLogType.debug:
        _logger.info(formattedMessage);
      case CallkeepLogType.error:
        _recordCrashlyticsError(formattedMessage, fatal: true);
        _logger.severe(formattedMessage);
      case CallkeepLogType.info:
        _logger.info(formattedMessage);
      case CallkeepLogType.verbose:
        _logger.info(formattedMessage);
      case CallkeepLogType.warn:
        _recordCrashlyticsError(formattedMessage);
        _logger.warning(formattedMessage);
    }
  }

  void _recordCrashlyticsError(
    String message, {
    bool fatal = false,
  }) {
    try {
      FirebaseCrashlytics.instance.recordError(
        Exception(message),
        null,
        fatal: fatal,
      );
    } catch (e) {
      _logger.warning('Failed to record error to FirebaseCrashlytics: $e');
    }
  }
}
