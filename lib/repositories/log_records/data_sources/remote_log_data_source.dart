import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/data/data.dart';

import 'log_data_source.dart';

class RemoteLogDataSource implements LogDataSource {
  final DatabaseReference _databaseReference;
  final List<String> _excludedLoggerNames;
  final String _userSessionId;
  final DeviceInfo _deviceInfo;
  final SecureStorage _secureStorage;

  RemoteLogDataSource()
      : _databaseReference = FirebaseDatabase.instance.ref().child('phone_logs'),
        _excludedLoggerNames = ['AppBlocObserver', 'AppRouterObserver'],
        _userSessionId = 'Session: ${DateFormat.yMMMd().add_Hm().format(DateTime.now()).toString()}',
        _deviceInfo = DeviceInfo(),
        _secureStorage = SecureStorage() {
    _initialize();
  }

  void _initialize() {
    final sanitizedDeviceInfo = _sanitizeKeys(_deviceInfo.data);
    _databaseReference.child(_userSessionId).set({
      'device_info': sanitizedDeviceInfo,
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

  void excludeLoggerNames(List<String> loggerNames) {
    _excludedLoggerNames.clear();
    _excludedLoggerNames.addAll(loggerNames);
  }

  @override
  Future<List<LogRecord>> getLogRecords() async {
    return [];
  }

  @override
  void addLogRecord(LogRecord record) {
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
