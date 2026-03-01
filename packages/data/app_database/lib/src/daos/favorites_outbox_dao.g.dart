// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_outbox_dao.dart';

// ignore_for_file: type=lint
mixin _$FavoritesOutboxDaoMixin on DatabaseAccessor<AppDatabase> {
  $FavoritesOutboxTableTable get favoritesOutboxTable =>
      attachedDatabase.favoritesOutboxTable;
  FavoritesOutboxDaoManager get managers => FavoritesOutboxDaoManager(this);
}

class FavoritesOutboxDaoManager {
  final _$FavoritesOutboxDaoMixin _db;
  FavoritesOutboxDaoManager(this._db);
  $$FavoritesOutboxTableTableTableManager get favoritesOutboxTable =>
      $$FavoritesOutboxTableTableTableManager(
        _db.attachedDatabase,
        _db.favoritesOutboxTable,
      );
}
