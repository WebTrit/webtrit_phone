// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_emails_dao.dart';

// ignore_for_file: type=lint
mixin _$ContactEmailsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ContactEmailsTableTable get contactEmailsTable =>
      attachedDatabase.contactEmailsTable;
  ContactEmailsDaoManager get managers => ContactEmailsDaoManager(this);
}

class ContactEmailsDaoManager {
  final _$ContactEmailsDaoMixin _db;
  ContactEmailsDaoManager(this._db);
  $$ContactEmailsTableTableTableManager get contactEmailsTable =>
      $$ContactEmailsTableTableTableManager(
        _db.attachedDatabase,
        _db.contactEmailsTable,
      );
}
