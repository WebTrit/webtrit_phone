import 'package:drift/drift.dart';

@DataClassName('DialogInfoData')
class DialogInfoTable extends Table {
  @override
  String get tableName => 'dialog_info';

  @override
  Set<Column> get primaryKey => {entityNumber, idKey};

  TextColumn get idKey => text()();

  TextColumn get entityNumber => text()();

  TextColumn get state => text()();

  TextColumn get callId => text().nullable()();

  TextColumn get direction => text().nullable()();

  TextColumn get localTag => text().nullable()();

  TextColumn get localNumber => text().nullable()();

  TextColumn get localDisplayName => text().nullable()();

  TextColumn get remoteTag => text().nullable()();

  TextColumn get remoteNumber => text().nullable()();

  TextColumn get remoteDisplayName => text().nullable()();

  TextColumn get arrivalVersion => text()();

  IntColumn get arrivalTimeUsec => integer()();
}
