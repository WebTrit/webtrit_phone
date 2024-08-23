import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/data/data.dart';

import 'log_data_source.dart';

class RemoteLogDataSource implements LogDataSource {
  final DeviceInfo _deviceInfo;
  final SecureStorage _secureStorage;
  final DatabaseReference _databaseReference;
  final FirebaseRemoteConfig _remoteConfig;
  final List<String> _excludedLoggerNames;
  final String _userSessionId;

  bool _firebaseRemoteLogging = false;

  RemoteLogDataSource()
      : _deviceInfo = DeviceInfo(),
        _secureStorage = SecureStorage(),
        _databaseReference = FirebaseDatabase.instance.ref().child('phone_logs'),
        _remoteConfig = FirebaseRemoteConfig.instance,
        _excludedLoggerNames = ['AppBlocObserver', 'AppRouterObserver'],
        _userSessionId = 'Session: ${DateFormat.yMMMd().add_Hm().format(DateTime.now()).toString()}' {
    _initialize();
  }

  void _initialize() async {
    try {
      await _remoteConfig.fetchAndActivate();
      _firebaseRemoteLogging = _remoteConfig.getBool('firebaseRemoteLogging');

      if (_firebaseRemoteLogging) {
        _initSessionData();
      }
    } catch (e) {
      Logger('RemoteLogDataSource').severe('Initialization failed', e);
    }
  }

  Future<void> _initSessionData() async {
    await _databaseReference.child(_userSessionId).set({
      'device_info': _sanitizeKeys(_deviceInfo.data),
      'storage_core': _secureStorage.readCoreUrl(),
      'storage_tenant_id': _secureStorage.readTenantId(),
    });
  }

  Map<String, dynamic> _sanitizeKeys(Map<String, dynamic> data) {
    final sanitizedData = <String, dynamic>{};
    data.forEach((key, value) {
      final sanitizedKey = key.replaceAll(RegExp(r'[.$#\[\]/]'), '_');
      sanitizedData[sanitizedKey] = value;
    });
    return sanitizedData;
  }

  @override
  Future<List<LogRecord>> getLogRecords() async {
    return [];
  }

  @override
  void addLogRecord(LogRecord record) {
    if (!_firebaseRemoteLogging) return;

    final logData = {
      'level': record.level.name,
      'message': record.message,
      'loggerName': record.loggerName,
      'time': record.time.toIso8601String(),
    };

    if (record.stackTrace != null) {
      logData['stackTrace'] = record.stackTrace!.toString();
    }

    if (!_excludedLoggerNames.contains(record.loggerName)) {
      _databaseReference.child(_userSessionId).child('records').push().set(logData);
    }
  }

  @override
  void clear() {
    _databaseReference.child(_userSessionId).remove();
  }

  @override
  Future<void> dispose() async {}
}
