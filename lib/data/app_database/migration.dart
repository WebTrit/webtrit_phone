import 'package:drift/drift.dart';

import 'app_database.dart';

abstract class Migration {
  const Migration();

  Future<void> execute(AppDatabase db, Migrator m);
}
