// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voicemail_dao.dart';

// ignore_for_file: type=lint
mixin _$VoicemailDaoMixin on DatabaseAccessor<AppDatabase> {
  $VoicemailTableTable get voicemailTable => attachedDatabase.voicemailTable;
  $ContactsTableTable get contactsTable => attachedDatabase.contactsTable;
  VoicemailDaoManager get managers => VoicemailDaoManager(this);
}

class VoicemailDaoManager {
  final _$VoicemailDaoMixin _db;
  VoicemailDaoManager(this._db);
  $$VoicemailTableTableTableManager get voicemailTable =>
      $$VoicemailTableTableTableManager(
        _db.attachedDatabase,
        _db.voicemailTable,
      );
  $$ContactsTableTableTableManager get contactsTable =>
      $$ContactsTableTableTableManager(_db.attachedDatabase, _db.contactsTable);
}
