import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

class MigrationV20 extends Migration {
  const MigrationV20();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    await db.customStatement('ALTER TABLE contact_phones RENAME TO contact_phones_old');

    await db.customStatement('''
      CREATE TABLE contact_phones (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        number TEXT NOT NULL,
        label TEXT NOT NULL,
        contact_id INTEGER NOT NULL REFERENCES contacts(id) ON DELETE CASCADE,
        inserted_at INTEGER NULL,
        updated_at INTEGER NULL,
        UNIQUE(number, label, contact_id)
      )
    ''');

    await db.customStatement('''
      INSERT INTO contact_phones (id, number, label, contact_id, inserted_at, updated_at)
      SELECT id, number, label, contact_id, inserted_at, updated_at
      FROM contact_phones_old
    ''');

    await db.customStatement('DROP TABLE contact_phones_old');

    await db.customStatement('''
      CREATE TRIGGER contact_phones_after_insert_trigger
        AFTER INSERT ON contact_phones
      BEGIN
        UPDATE contact_phones SET inserted_at = STRFTIME('%s', 'NOW') WHERE id = NEW.id AND inserted_at IS NULL;
        UPDATE contact_phones SET updated_at = STRFTIME('%s', 'NOW') WHERE id = NEW.id;
      END
    ''');

    await db.customStatement('''
      CREATE TRIGGER contact_phones_after_update_trigger
        AFTER UPDATE ON contact_phones
      BEGIN
        UPDATE contact_phones SET updated_at = STRFTIME('%s', 'NOW') WHERE id = NEW.id;
      END
    ''');
  }
}
