import 'package:drift/drift.dart';

@DataClassName('ContactEmailData')
class ContactEmailsTable extends Table {
  @override
  String get tableName => 'contact_emails';

  IntColumn get id => integer().autoIncrement()();

  TextColumn get address => text()();

  TextColumn get label => text()();

  IntColumn get contactId => integer()
      .customConstraint('NOT NULL REFERENCES contacts(id) ON DELETE CASCADE')();

  DateTimeColumn get insertedAt => dateTime().nullable()();

  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  List<String> get customConstraints => [
        'UNIQUE(address, contact_id)',
      ];
}
