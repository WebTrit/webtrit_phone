import 'package:logging/logging.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

class CallkeepLogs implements CallkeepLogsDelegate {
  final _logger = Logger('CallkeepLogs');

  @override
  void onLog(CallkeepLogType type, String tag, String message) {
    _logger.info('$tag $message');
  }
}
