import 'package:drift/drift.dart';

enum ContactSourceTypeEnum { local, external }

@DataClassName('ContactData')
class ContactsTable extends Table {
  @override
  String get tableName => 'contacts';

  IntColumn get id => integer().autoIncrement()();

  IntColumn get sourceType => intEnum<ContactSourceTypeEnum>()();

  TextColumn get sourceId => text()();

  TextColumn get firstName => text().nullable()();

  TextColumn get lastName => text().nullable()();

  TextColumn get aliasName => text().nullable()();

  BlobColumn get thumbnail => blob().nullable()();

  BoolColumn get registered => boolean().nullable()();

  BoolColumn get userRegistered => boolean().nullable()();

  BoolColumn get isCurrentUser => boolean().nullable()();

  DateTimeColumn get insertedAt => dateTime().nullable()();

  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  List<String> get customConstraints => [
        'UNIQUE(source_type, source_id)',
      ];
}
