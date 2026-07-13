import 'package:drift/drift.dart';

@DataClassName('VoicemailData')
class VoicemailTable extends Table {
  @override
  String get tableName => 'voicemails';

  @override
  Set<Column> get primaryKey => {id};

  TextColumn get id => text()();

  TextColumn get date => text()();

  RealColumn get duration => real()();

  TextColumn get sender => text()();

  TextColumn get receiver => text()();

  BoolColumn get seen => boolean().withDefault(const Constant(false))();

  IntColumn get size => integer()();

  TextColumn get type => text()();

  TextColumn get attachmentPath => text().nullable()();
}
