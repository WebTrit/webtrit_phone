import 'dart:io';

import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/environment_config.dart';

class AppLogger {
  static late AppLogger _instance;

  static Future<AppLogger> init() async {
    hierarchicalLoggingEnabled = true;

    final logLevel = Level.LEVELS.firstWhere((level) => level.name == EnvironmentConfig.DEBUG_LEVEL);
    PrintAppender.setupLogging(level: logLevel);

    if (Platform.isAndroid) WebtritCallkeepLogs().setLogsDelegate(CallkeepLogs());

    _instance = AppLogger._();
    return _instance;
  }

  factory AppLogger() {
    return _instance;
  }

  AppLogger._();
}
