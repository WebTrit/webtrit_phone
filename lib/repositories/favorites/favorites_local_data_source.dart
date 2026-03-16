import 'package:app_database/app_database.dart';

import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

abstract class FavoritesLocalDataSource {
  Stream<List<FavoriteWithContact>> watchAllWithContacts();

  Future<void> add(Favorite favorite);

  Future<void> remove(Favorite favorite);

  Future<void> shift(Favorite favorite, int position);

  Future<void> batchReplace(List<Favorite> favorites, {bool removePrevious = false});

  Future<List<FavoriteOutboxAction>> getAllOutboxActions();

  Future<void> setOutboxAction(FavoriteOutboxAction action, {bool replacePrevAction = false});

  Future<void> removeOutboxAction(FavoriteOutboxAction action);
}

class FavoritesLocalDataSourceDriftImpl
    with
        DialogInfoDriftMapper,
        PresenceInfoDriftMapper,
        ContactsDriftMapper,
        FavoritesDriftMapper,
        FavoriteOutboxActionDriftMapper
    implements FavoritesLocalDataSource {
  FavoritesLocalDataSourceDriftImpl(this._appDatabase);

  final AppDatabase _appDatabase;
  late final _dao = _appDatabase.favoritesV2Dao;

  @override
  Stream<List<FavoriteWithContact>> watchAllWithContacts() {
    return _dao.watchWithContacts().map((data) => data.map((e) => favoriteWithContactFromDrift(e)).toList());
  }

  @override
  Future<void> add(Favorite favorite) {
    final data = favoriteToDrift(favorite);
    return _dao.add(data.number, data.sourceType, data.sourceId, data.label);
  }

  @override
  Future<void> remove(Favorite favorite) {
    return _dao.remove(favoriteKeyFromFavorite(favorite));
  }

  @override
  Future<void> shift(Favorite favorite, int position) {
    return _dao.shift(favoriteKeyFromFavorite(favorite), position);
  }

  @override
  Future<void> batchReplace(List<Favorite> favorites, {bool removePrevious = false}) {
    return _dao.batchReplace(favorites.map(favoriteToDrift).toList(), removePrevious: removePrevious);
  }

  @override
  Future<List<FavoriteOutboxAction>> getAllOutboxActions() async {
    final entries = await _dao.getAllOutboxEntries();
    return entries.map(favoriteOutboxActionFromDrift).toList();
  }

  @override
  Future<void> setOutboxAction(FavoriteOutboxAction action, {bool replacePrevAction = false}) {
    return _dao.setOutboxEntry(favoriteOutboxActionToDrift(action), replacePrevAction: replacePrevAction);
  }

  @override
  Future<void> removeOutboxAction(FavoriteOutboxAction action) {
    return _dao.removeOutboxEntry(
      FavoriteOutboxActionData.values.byName(action.action.name),
      action.number,
      FavoriteSourceTypeData.values.byName(action.sourceType.name),
    );
  }
}
