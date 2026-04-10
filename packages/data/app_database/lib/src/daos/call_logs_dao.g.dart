// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_logs_dao.dart';

// ignore_for_file: type=lint
mixin _$CallLogsDaoMixin on DatabaseAccessor<AppDatabase> {
  $CallLogsTableTable get callLogsTable => attachedDatabase.callLogsTable;
  CallLogsDaoManager get managers => CallLogsDaoManager(this);
}

class CallLogsDaoManager {
  final _$CallLogsDaoMixin _db;
  CallLogsDaoManager(this._db);
  $$CallLogsTableTableTableManager get callLogsTable =>
      $$CallLogsTableTableTableManager(_db.attachedDatabase, _db.callLogsTable);
}
