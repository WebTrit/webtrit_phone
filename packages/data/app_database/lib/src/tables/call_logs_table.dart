import 'package:drift/drift.dart';

enum CallLogDirectionEnum { incoming, outgoing }

@DataClassName('CallLogData')
class CallLogsTable extends Table {
  @override
  String get tableName => 'call_logs';

  IntColumn get id => integer().autoIncrement()();

  IntColumn get direction => intEnum<CallLogDirectionEnum>()();

  TextColumn get number => text().customConstraint(
      'NOT NULL CONSTRAINT "call_logs.number not_empty" CHECK (length(number) > 0)')();

  TextColumn get username => text().nullable()();

  BoolColumn get video => boolean()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get acceptedAt => dateTime().nullable()();

  DateTimeColumn get hungUpAt => dateTime().nullable()();
}
