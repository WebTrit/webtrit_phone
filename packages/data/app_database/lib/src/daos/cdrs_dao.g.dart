// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cdrs_dao.dart';

// ignore_for_file: type=lint
mixin _$CdrsDaoMixin on DatabaseAccessor<AppDatabase> {
  $CdrTableTable get cdrTable => attachedDatabase.cdrTable;
  $CdrSyncCursorTableTable get cdrSyncCursorTable =>
      attachedDatabase.cdrSyncCursorTable;
  CdrsDaoManager get managers => CdrsDaoManager(this);
}

class CdrsDaoManager {
  final _$CdrsDaoMixin _db;
  CdrsDaoManager(this._db);
  $$CdrTableTableTableManager get cdrTable =>
      $$CdrTableTableTableManager(_db.attachedDatabase, _db.cdrTable);
  $$CdrSyncCursorTableTableTableManager get cdrSyncCursorTable =>
      $$CdrSyncCursorTableTableTableManager(
        _db.attachedDatabase,
        _db.cdrSyncCursorTable,
      );
}
