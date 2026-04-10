// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presence_info_dao.dart';

// ignore_for_file: type=lint
mixin _$PresenceInfoDaoMixin on DatabaseAccessor<AppDatabase> {
  $PresenceInfoTableTable get presenceInfoTable =>
      attachedDatabase.presenceInfoTable;
  PresenceInfoDaoManager get managers => PresenceInfoDaoManager(this);
}

class PresenceInfoDaoManager {
  final _$PresenceInfoDaoMixin _db;
  PresenceInfoDaoManager(this._db);
  $$PresenceInfoTableTableTableManager get presenceInfoTable =>
      $$PresenceInfoTableTableTableManager(
        _db.attachedDatabase,
        _db.presenceInfoTable,
      );
}
