import 'package:drift/drift.dart';

@DataClassName('OutboxAttachmentData')
class OutboxAttachmentTable extends Table {
  @override
  String get tableName => 'outbox_attachments';

  @override
  Set<Column> get primaryKey => {idKey};

  TextColumn get idKey => text()();

  TextColumn get messageIdKey => text()();

  TextColumn get pickedPath => text()();

  TextColumn get encodedPath => text().nullable()();

  TextColumn get uploadedPath => text().nullable()();
}
