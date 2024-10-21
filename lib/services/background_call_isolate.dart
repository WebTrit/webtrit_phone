import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_phone/environment_config.dart';

import 'background_call_handler.dart';


final _logger = Logger('IsolateBackgroundCallHandler');
BackgroundCallHandler? _isolateBackgroundHandler;
bool _launchingBackgroundSignaling = false;

void _initLogs() {
  hierarchicalLoggingEnabled = true;
  final logLevel = Level.LEVELS.firstWhere((level) => level.name == EnvironmentConfig.DEBUG_LEVEL);
  PrintAppender.setupLogging(level: logLevel);
}

Future<void> _initSignaling({
  bool terminateServiceOnActivityLaunch = false,
}) async {
  _logger.info('Initializing background signaling');
  _isolateBackgroundHandler ??= await BackgroundCallHandler.init();
  _isolateBackgroundHandler?.launch();

  if (terminateServiceOnActivityLaunch) {
    _isolateBackgroundHandler?.onCallCompletion = () {
      _closeSignaling();
      CallkeepBackgroundService().tearDownActivity();
    };
  }
}

void _closeSignaling() {
  _logger.info('Closing background signaling');
  _isolateBackgroundHandler?.close();
  _isolateBackgroundHandler = null;
}

@pragma('vm:entry-point')
Future<void> onStartForegroundService(CallkeepServiceStatus status) async {
  _initLogs();
  if (!status.autoRestart) {
    await _initSignaling(terminateServiceOnActivityLaunch: true);
  }
}

@pragma('vm:entry-point')
Future<void> onChangedLifecycle(CallkeepServiceStatus status) async {
  switch (status.lifecycle) {
    case CallkeepAppLifecycleType.onStop:
      if (status.autoRestart) {
        _launchingBackgroundSignaling = false;
        await _initSignaling(terminateServiceOnActivityLaunch:false);
      }
      break;
    case CallkeepAppLifecycleType.onResume:
      if (!_launchingBackgroundSignaling && status.activityReady) {
        _launchingBackgroundSignaling = true;
        _closeSignaling();
      }
      break;
    default:
      break;
  }
}
