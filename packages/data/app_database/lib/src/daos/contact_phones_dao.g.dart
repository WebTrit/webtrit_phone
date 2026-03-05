// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_phones_dao.dart';

// ignore_for_file: type=lint
mixin _$ContactPhonesDaoMixin on DatabaseAccessor<AppDatabase> {
  $ContactsTableTable get contactsTable => attachedDatabase.contactsTable;
  $ContactPhonesTableTable get contactPhonesTable =>
      attachedDatabase.contactPhonesTable;
  $FavoritesTableTable get favoritesTable => attachedDatabase.favoritesTable;
  ContactPhonesDaoManager get managers => ContactPhonesDaoManager(this);
}

class ContactPhonesDaoManager {
  final _$ContactPhonesDaoMixin _db;
  ContactPhonesDaoManager(this._db);
  $$ContactsTableTableTableManager get contactsTable =>
      $$ContactsTableTableTableManager(_db.attachedDatabase, _db.contactsTable);
  $$ContactPhonesTableTableTableManager get contactPhonesTable =>
      $$ContactPhonesTableTableTableManager(
        _db.attachedDatabase,
        _db.contactPhonesTable,
      );
  $$FavoritesTableTableTableManager get favoritesTable =>
      $$FavoritesTableTableTableManager(
        _db.attachedDatabase,
        _db.favoritesTable,
      );
}
