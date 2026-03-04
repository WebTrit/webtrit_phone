// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recents_dao.dart';

// ignore_for_file: type=lint
mixin _$RecentsDaoMixin on DatabaseAccessor<AppDatabase> {
  $CallLogsTableTable get callLogsTable => attachedDatabase.callLogsTable;
  $ContactsTableTable get contactsTable => attachedDatabase.contactsTable;
  $ContactPhonesTableTable get contactPhonesTable =>
      attachedDatabase.contactPhonesTable;
  $ContactEmailsTableTable get contactEmailsTable =>
      attachedDatabase.contactEmailsTable;
  $PresenceInfoTableTable get presenceInfoTable =>
      attachedDatabase.presenceInfoTable;
  RecentsDaoManager get managers => RecentsDaoManager(this);
}

class RecentsDaoManager {
  final _$RecentsDaoMixin _db;
  RecentsDaoManager(this._db);
  $$CallLogsTableTableTableManager get callLogsTable =>
      $$CallLogsTableTableTableManager(_db.attachedDatabase, _db.callLogsTable);
  $$ContactsTableTableTableManager get contactsTable =>
      $$ContactsTableTableTableManager(_db.attachedDatabase, _db.contactsTable);
  $$ContactPhonesTableTableTableManager get contactPhonesTable =>
      $$ContactPhonesTableTableTableManager(
        _db.attachedDatabase,
        _db.contactPhonesTable,
      );
  $$ContactEmailsTableTableTableManager get contactEmailsTable =>
      $$ContactEmailsTableTableTableManager(
        _db.attachedDatabase,
        _db.contactEmailsTable,
      );
  $$PresenceInfoTableTableTableManager get presenceInfoTable =>
      $$PresenceInfoTableTableTableManager(
        _db.attachedDatabase,
        _db.presenceInfoTable,
      );
}
