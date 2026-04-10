import 'package:drift/drift.dart';

import 'favorites_v2_table.dart';

enum FavoriteOutboxActionData { upsert, delete }

@DataClassName('FavoriteOutboxEntryData')
class FavoritesOutboxTable extends Table {
  @override
  String get tableName => 'favorites_outbox';

  @override
  Set<Column> get primaryKey => {number, sourceType, action};

  TextColumn get number => text()();

  TextColumn get sourceType => textEnum<FavoriteSourceTypeData>()();

  TextColumn get action => textEnum<FavoriteOutboxActionData>()();

  TextColumn get sourceId => text().nullable()();

  TextColumn get label => text().nullable()();

  IntColumn get position => integer().nullable()();

  IntColumn get sendAttempts => integer().withDefault(const Constant(0))();

  IntColumn get timestampUsec => integer()();
}
