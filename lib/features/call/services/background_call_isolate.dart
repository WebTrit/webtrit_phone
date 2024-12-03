import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import 'background_call_event_service.dart';

CallkeepBackgroundService? _callkeep;
BackgroundCallEventService? _backgroundCallEventManager;

AppLogger? _appLogger;
AppPreferences? _appPreferences;
SecureStorage? _secureStorage;
AppCertificates? _appCertificates;

CallLogsRepository? _callLogsRepository;

Future<void> _initializeDependencies() async {
  // Initialize the logger for handling Callkeep in the background isolate.
  _appLogger ??= await AppLogger.init();
  _appPreferences ??= await AppPreferences.init();
  _appCertificates ??= await AppCertificates.init();

  // Always create a new instance to avoid caching issues
  _secureStorage = await SecureStorage.init();

  _callLogsRepository ??= CallLogsRepository(appDatabase: await IsolateDatabase.create());
  _callkeep ??= CallkeepBackgroundService();

  _backgroundCallEventManager ??= BackgroundCallEventService(
    callLogsRepository: _callLogsRepository!,
    appPreferences: _appPreferences!,
    callkeep: _callkeep!,
    storage: _secureStorage!,
    certificates: _appCertificates!.trustedCertificates,
  );
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
