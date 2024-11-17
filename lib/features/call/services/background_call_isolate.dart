import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import 'background_call_event_service.dart';

CallkeepBackgroundService? _callkeep;
BackgroundCallEventService? _backgroundCallEventManager;

AppPreferences? _appPreferences;
SecureStorage? _secureStorage;
AppCertificates? _appCertificates;

RecentsRepository? _recentsRepository;

Future<void> _initializeDependencies() async {
  _appPreferences ??= await AppPreferences.init();
  _appCertificates ??= await AppCertificates.init();

  // Always create a new instance to avoid caching issues
  _secureStorage = await SecureStorage.init();

  _recentsRepository ??= RecentsRepository(appDatabase: await IsolateDatabase.create());
  _callkeep ??= CallkeepBackgroundService();

  _backgroundCallEventManager ??= BackgroundCallEventService(
    recentsRepository: _recentsRepository!,
    callkeep: _callkeep!,
    storage: _secureStorage!,
    certificates: _appCertificates!.trustedCertificates,
  );

  _backgroundCallEventManager?.incomingCallType = _appPreferences!.getIncomingCallType();

  hierarchicalLoggingEnabled = true;
  final logLevel = Level.LEVELS.firstWhere((level) => level.name == EnvironmentConfig.DEBUG_LEVEL);
  PrintAppender.setupLogging(level: logLevel);
}

@pragma('vm:entry-point')
Future<void> onStart(CallkeepServiceStatus status) async {
  await _initializeDependencies();
  await _backgroundCallEventManager?.onStart(status);
}

@pragma('vm:entry-point')
Future<void> onChangedLifecycle(CallkeepServiceStatus status) async {
  await _backgroundCallEventManager?.onChangedLifecycle(status);
}
