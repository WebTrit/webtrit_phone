import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

class MigrationV4 extends Migration {
  const MigrationV4();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    await m.createTable(db.chatsTable);
    await m.createTable(db.chatMembersTable);
    await m.createTable(db.chatMessagesTable);
  }
}
