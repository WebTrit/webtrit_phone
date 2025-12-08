import 'package:drift/drift.dart';

@DataClassName('PresenceInfoData')
class PresenceInfoTable extends Table {
  @override
  String get tableName => 'presence_info';

  @override
  Set<Column> get primaryKey => {idKey};

  TextColumn get idKey => text()();

  TextColumn get number => text()();

  BoolColumn get available => boolean()();

  TextColumn get note => text()();

  TextColumn get statusIcon => text().nullable()();

  TextColumn get device => text().nullable()();

  IntColumn get timeOffsetMin => integer().nullable()();

  IntColumn get timestampUsec => integer().nullable()();

  TextColumn get activitiesJson => text()();
}
