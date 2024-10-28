import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/models/models.dart';

import '../data/app_preferences.dart';
import 'background_call_service.dart';

final _logger = Logger('IsolateBackgroundCallHandler');

BackgroundCallService? _isolateBackgroundHandler;
bool _launchingBackgroundSignaling = false;

Future<void> _initializeDependencies() async {
  await AppPreferences.init();

  hierarchicalLoggingEnabled = true;
  final logLevel = Level.LEVELS.firstWhere((level) => level.name == EnvironmentConfig.DEBUG_LEVEL);
  PrintAppender.setupLogging(level: logLevel);
}

@pragma('vm:entry-point')
Future<void> onStart(CallkeepServiceStatus status, Map<String, dynamic> data) async {
  _initializeDependencies();

  _logger.info('Starting background signaling with data: $data status: $status');

  var incomingCallTypeData = data[CallkeepBackgroundService.incomingCallType] ?? IncomingCallType.socket.name;
  final incomingCallType = IncomingCallType.values.byName(incomingCallTypeData);

  _isolateBackgroundHandler ??= await BackgroundCallService.init(incomingCallType);

  if (incomingCallType == IncomingCallType.pushNotification) {
    _isolateBackgroundHandler?.launch();
  }
}

@pragma('vm:entry-point')
Future<void> onChangedLifecycle(CallkeepServiceStatus status) async {
  switch (status.lifecycle) {
    case CallkeepLifecycleType.onStop:
      if (status.autoRestartOnTerminate && !status.activeCalls) {
        _launchingBackgroundSignaling = false;
        _isolateBackgroundHandler?.launch();
      }
      break;
    case CallkeepLifecycleType.onResume:
      if (!_launchingBackgroundSignaling && status.activityReady) {
        await _closeSignaling();
      }
      break;
    default:
      break;
  }
}

Future _closeSignaling() async {
  _logger.info('Closing background signaling');
  await _isolateBackgroundHandler?.close();
}
