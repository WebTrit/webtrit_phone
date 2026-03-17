import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

import 'generated/schema_v22.dart' as v22;

class MigrationV22 extends Migration {
  const MigrationV22();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    final sipSubscriptionsTable = v22.SipSubscriptions(db);
    await m.createTable(sipSubscriptionsTable);

    final sipSubscriptionsOutboxTable = v22.SipSubscriptionsOutbox(db);
    await m.createTable(sipSubscriptionsOutboxTable);
  }
}
