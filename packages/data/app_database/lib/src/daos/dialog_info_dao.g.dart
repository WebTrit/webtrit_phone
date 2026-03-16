// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialog_info_dao.dart';

// ignore_for_file: type=lint
mixin _$DialogInfoDaoMixin on DatabaseAccessor<AppDatabase> {
  $DialogInfoTableTable get dialogInfoTable => attachedDatabase.dialogInfoTable;
  DialogInfoDaoManager get managers => DialogInfoDaoManager(this);
}

class DialogInfoDaoManager {
  final _$DialogInfoDaoMixin _db;
  DialogInfoDaoManager(this._db);
  $$DialogInfoTableTableTableManager get dialogInfoTable =>
      $$DialogInfoTableTableTableManager(
        _db.attachedDatabase,
        _db.dialogInfoTable,
      );
}
