import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

import 'generated/schema_v11.dart' as v11;

class MigrationV11 extends Migration {
  const MigrationV11();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    final chatsTable = v11.Chats(db);

    // Update chats type value change from 'dialog' to 'direct'
    final [
      tableName,
      columnName
    ] = [chatsTable.aliasedName, chatsTable.type.$name];
    final [oldType, newType] = ['dialog', 'direct'];
    await db.customUpdate(
      'UPDATE $tableName SET $columnName = ? WHERE $columnName = ?',
      variables: [Variable(newType), Variable(oldType)],
    );
  }
}
