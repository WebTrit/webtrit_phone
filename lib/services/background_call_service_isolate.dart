import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/models/models.dart';

import '../data/app_preferences.dart';
import 'background_call_service.dart';

final _logger = Logger('IsolateBackgroundCallHandler');

BackgroundCallHandler? _isolateBackgroundHandler;
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

  var incomingCallTypeData = data[CallkeepBackgroundService.incomingCallType] ?? IncomingCallType.socket.name;
  final incomingCallType = IncomingCallType.values.byName(incomingCallTypeData);

  if (incomingCallType == IncomingCallType.pushNotification) {
    await _initSignaling(terminateServiceOnActivityLaunch: true);
  } else {
    _logger.info('Call type is not push notification, so not initializing signaling');
  }
}

@pragma('vm:entry-point')
Future<void> onChangedLifecycle(CallkeepServiceStatus status) async {
  switch (status.lifecycle) {
    case CallkeepLifecycleType.onStop:
      if (status.autoRestartOnTerminate) {
        _launchingBackgroundSignaling = false;
        await _initSignaling();
      }
      break;
    case CallkeepLifecycleType.onResume:
      if (!_launchingBackgroundSignaling && status.activityReady) {
        _launchingBackgroundSignaling = true;
        _closeSignaling();
      }
      break;
    default:
      break;
  }
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
      CallkeepBackgroundService().setUp(autoRestartOnTerminate: false, autoStartOnBoot: false);
      CallkeepBackgroundService().stopService();
      CallkeepBackgroundService().finishActivity();
    };
  }
}

void _closeSignaling() {
  _logger.info('Closing background signaling');
  _isolateBackgroundHandler?.close();
  _isolateBackgroundHandler = null;
}
