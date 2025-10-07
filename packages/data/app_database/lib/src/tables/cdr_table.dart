import 'package:drift/drift.dart';

enum CdrStatusData { accepted, declined, missed, error }

enum CallDirectionData { incoming, outgoing, forwarded }

@DataClassName('CdrRecordData')
class CdrTable extends Table {
  @override
  String get tableName => 'cdrs';

  @override
  Set<Column> get primaryKey => {callId};

  TextColumn get callId => text().unique()();

  TextColumn get direction => textEnum<CallDirectionData>()();

  TextColumn get status => textEnum<CdrStatusData>()();

  TextColumn get callee => text()();

  TextColumn get caller => text()();

  IntColumn get connectTimeUsec => integer()();

  IntColumn get disconnectTimeUsec => integer()();

  TextColumn get disconnectReason => text()();

  IntColumn get durationSeconds => integer()();

  TextColumn get recordingId => text().nullable()();
}
