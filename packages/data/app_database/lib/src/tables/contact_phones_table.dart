import 'package:drift/drift.dart';

@DataClassName('ContactPhoneData')
class ContactPhonesTable extends Table {
  @override
  String get tableName => 'contact_phones';

  IntColumn get id => integer().autoIncrement()();

  TextColumn get number => text()();

  TextColumn get label => text()();

  IntColumn get contactId => integer().customConstraint('NOT NULL REFERENCES contacts(id) ON DELETE CASCADE')();

  DateTimeColumn get insertedAt => dateTime().nullable()();

  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  List<String> get customConstraints => [
        'UNIQUE(number, contact_id)',
      ];
}
