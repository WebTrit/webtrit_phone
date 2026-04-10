// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_dao.dart';

// ignore_for_file: type=lint
mixin _$ContactsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ContactsTableTable get contactsTable => attachedDatabase.contactsTable;
  $ContactPhonesTableTable get contactPhonesTable =>
      attachedDatabase.contactPhonesTable;
  $ContactEmailsTableTable get contactEmailsTable =>
      attachedDatabase.contactEmailsTable;
  $FavoritesTableTable get favoritesTable => attachedDatabase.favoritesTable;
  $FavoritesV2TableTable get favoritesV2Table =>
      attachedDatabase.favoritesV2Table;
  $PresenceInfoTableTable get presenceInfoTable =>
      attachedDatabase.presenceInfoTable;
  ContactsDaoManager get managers => ContactsDaoManager(this);
}

class ContactsDaoManager {
  final _$ContactsDaoMixin _db;
  ContactsDaoManager(this._db);
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
  $$FavoritesTableTableTableManager get favoritesTable =>
      $$FavoritesTableTableTableManager(
        _db.attachedDatabase,
        _db.favoritesTable,
      );
  $$FavoritesV2TableTableTableManager get favoritesV2Table =>
      $$FavoritesV2TableTableTableManager(
        _db.attachedDatabase,
        _db.favoritesV2Table,
      );
  $$PresenceInfoTableTableTableManager get presenceInfoTable =>
      $$PresenceInfoTableTableTableManager(
        _db.attachedDatabase,
        _db.presenceInfoTable,
      );
}
