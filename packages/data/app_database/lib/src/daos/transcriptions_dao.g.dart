// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transcriptions_dao.dart';

// ignore_for_file: type=lint
mixin _$TranscriptionsDaoMixin on DatabaseAccessor<AppDatabase> {
  $TranscriptionTableTable get transcriptionTable =>
      attachedDatabase.transcriptionTable;
  TranscriptionsDaoManager get managers => TranscriptionsDaoManager(this);
}

class TranscriptionsDaoManager {
  final _$TranscriptionsDaoMixin _db;
  TranscriptionsDaoManager(this._db);
  $$TranscriptionTableTableTableManager get transcriptionTable =>
      $$TranscriptionTableTableTableManager(
        _db.attachedDatabase,
        _db.transcriptionTable,
      );
}
