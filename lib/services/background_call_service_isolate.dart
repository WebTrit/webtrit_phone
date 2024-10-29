import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/models/models.dart';

import '../data/app_preferences.dart';
import 'background_call_service.dart';

final _logger = Logger('IsolateBackgroundCallHandler');

BackgroundCallService? _isolateBackgroundHandler;

Future<void> _initializeDependencies() async {
  await AppPreferences.init();

  hierarchicalLoggingEnabled = true;
  final logLevel = Level.LEVELS.firstWhere((level) => level.name == EnvironmentConfig.DEBUG_LEVEL);
  PrintAppender.setupLogging(level: logLevel);
}

@pragma('vm:entry-point')
Future<void> onStart(CallkeepServiceStatus status) async {
  _initializeDependencies();

  _logger.info(
      'onStart: ${status.type} lifecycle: ${status.lifecycle} activeCalls: ${status.activeCalls} autoRestartOnTerminate: ${status.autoRestartOnTerminate} activityReady: ${status.activityReady} lockScreen: ${status.lockScreen} autoStartOnBoot: ${status.autoStartOnBoot}');

  _isolateBackgroundHandler ??= await BackgroundCallService.init();
  _isolateBackgroundHandler?.setIncomingCallType(
      status.type == CallkeepIncomingType.socket ? IncomingCallType.socket : IncomingCallType.pushNotification);

  if (status.lifecycle == CallkeepLifecycleType.onStop ||
      status.lifecycle == CallkeepLifecycleType.onAny ||
      status.lifecycle == CallkeepLifecycleType.onDestroy) {
    _logger.info('launching isolateBackgroundHandler $_isolateBackgroundHandler');
    _isolateBackgroundHandler?.launch();
  }
}

@pragma('vm:entry-point')
Future<void> onChangedLifecycle(CallkeepServiceStatus status) async {
  switch (status.lifecycle) {
    case CallkeepLifecycleType.onStop:
      if (status.autoRestartOnTerminate && !status.activeCalls) {
        _logger.info('onChangedLifecycle launch');
        _isolateBackgroundHandler?.launch();
      }
      break;
    case CallkeepLifecycleType.onResume:
      if (status.activityReady) {
        _logger.info('onChangedLifecycle close');
        await _isolateBackgroundHandler?.close();
      }
      break;
    default:
      break;
  }
}
