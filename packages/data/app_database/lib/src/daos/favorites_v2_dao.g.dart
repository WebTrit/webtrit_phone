// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_v2_dao.dart';

// ignore_for_file: type=lint
mixin _$FavoritesV2DaoMixin on DatabaseAccessor<AppDatabase> {
  $FavoritesV2TableTable get favoritesV2Table =>
      attachedDatabase.favoritesV2Table;
  $ContactsTableTable get contactsTable => attachedDatabase.contactsTable;
  $ContactPhonesTableTable get contactPhonesTable =>
      attachedDatabase.contactPhonesTable;
  $ContactEmailsTableTable get contactEmailsTable =>
      attachedDatabase.contactEmailsTable;
  $PresenceInfoTableTable get presenceInfoTable =>
      attachedDatabase.presenceInfoTable;
  FavoritesV2DaoManager get managers => FavoritesV2DaoManager(this);
}

class FavoritesV2DaoManager {
  final _$FavoritesV2DaoMixin _db;
  FavoritesV2DaoManager(this._db);
  $$FavoritesV2TableTableTableManager get favoritesV2Table =>
      $$FavoritesV2TableTableTableManager(
        _db.attachedDatabase,
        _db.favoritesV2Table,
      );
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
