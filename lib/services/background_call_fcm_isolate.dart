import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

import '../environment_config.dart';

final _logger = Logger('BackgroundCallFcmIsolate');

Future<void> _initializeDependencies() async {
  await AppPreferences.init();

  hierarchicalLoggingEnabled = true;
  final logLevel = Level.LEVELS.firstWhere((level) => level.name == EnvironmentConfig.DEBUG_LEVEL);
  PrintAppender.setupLogging(level: logLevel);
}

Future<void> initializeCall(Map<String, dynamic> message) async {
  await _initializeDependencies();

  final callType = AppPreferences().getIncomingCallType();
  final callkeepBackgroundService = CallkeepBackgroundService();

  if (callType == IncomingCallType.pushNotification) {
    callkeepBackgroundService.startService(data: {
      CallkeepBackgroundService.incomingCallType: callType.name,
      ...message,
    });
  } else {
    _logger.info('Call type is not push notification, so skip initializing signaling');
  }
}
