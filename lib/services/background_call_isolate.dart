import 'dart:isolate';

import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import '../environment_config.dart';
import 'background_call_handler.dart';

final _logger = Logger('IsolateBackgroundCallHandler');

BackgroundCallHandler? _isolateBackgroundHandler;

bool _launchingBackgroundSignaling = false;

void _initLogs() {
  hierarchicalLoggingEnabled = true;
  PrintAppender.setupLogging(level: Level.LEVELS.firstWhere((level) => level.name == EnvironmentConfig.DEBUG_LEVEL));
}

void _initSignaling() async {
  _logger.info('Initializing background signaling');
  _isolateBackgroundHandler = _isolateBackgroundHandler ?? (await BackgroundCallHandler.init());
  _isolateBackgroundHandler?.launch();
}

void _closeSignaling() async {
  _logger.info('Closing background signaling');
  if (_isolateBackgroundHandler != null) {
    _isolateBackgroundHandler?.close();
    _isolateBackgroundHandler = null;
  }
}

@pragma('vm:entry-point')
Future<void> onStartForegroundService(CallkeepServiceStatus status) async {
  _initLogs();

  // if (!status.autoRestart) {
  //   _initSignaling();
  // }
}

@pragma('vm:entry-point')
Future<void> onChangedLifecycle(CallkeepServiceStatus status) async {
  if (status.lifecycle == CallkeepAppLifecycleType.onStop) {
    _launchingBackgroundSignaling = false;
    _initSignaling();
  }

  if (status.lifecycle == CallkeepAppLifecycleType.onResume && !_launchingBackgroundSignaling && status.activityReady) {
    _launchingBackgroundSignaling = true;
    _closeSignaling();
  }
}
