import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

import 'generated/schema_v10.dart' as v10;

class MigrationV10 extends Migration {
  const MigrationV10();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    final chatsTable = v10.Chats(db);

    // Update chats type value change from 'dialog' to 'direct'
    final [tableName, columnName] = [chatsTable.aliasedName, chatsTable.type.$name];
    final [oldType, newType] = ['dialog', 'direct'];
    await db.customUpdate(
      'UPDATE $tableName SET $columnName = ? WHERE $columnName = ?',
      variables: [Variable(newType), Variable(oldType)],
    );
  }
}
