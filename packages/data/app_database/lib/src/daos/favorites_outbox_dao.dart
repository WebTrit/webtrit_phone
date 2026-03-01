import 'package:app_database/src/app_database.dart';
import 'package:drift/drift.dart';

part 'favorites_outbox_dao.g.dart';

@DriftAccessor(tables: [FavoritesOutboxTable])
class FavoritesOutboxDao extends DatabaseAccessor<AppDatabase> with _$FavoritesOutboxDaoMixin {
  FavoritesOutboxDao(super.db);

  Future<void> set(FavoriteOutboxEntryData entry, bool replacePrevAction) {
    if (!replacePrevAction) {
      return into(favoritesOutboxTable).insertOnConflictUpdate(entry);
    }
    return transaction(() async {
      await (delete(favoritesOutboxTable)
            ..where((table) => table.number.equals(entry.number))
            ..where((table) => table.sourceType.equals(entry.sourceType.name)))
          .go();
      await into(favoritesOutboxTable).insertOnConflictUpdate(entry);
    });
  }

  Future<int> remove(FavoriteOutboxActionData action, String number, FavoriteSourceTypeData sourceType) {
    return (delete(favoritesOutboxTable)
          ..where((table) => table.action.equals(action.name))
          ..where((table) => table.number.equals(number))
          ..where((table) => table.sourceType.equals(sourceType.name)))
        .go();
  }

  Future<List<FavoriteOutboxEntryData>> getAll() {
    final query = select(favoritesOutboxTable)..orderBy([(table) => OrderingTerm.asc(table.timestampUsec)]);
    return query.get();
  }
}
