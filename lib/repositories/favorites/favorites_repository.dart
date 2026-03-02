import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart' as api;

import 'package:webtrit_phone/common/refreshable.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/services/services.dart';

final _logger = Logger('FavoritesRepository');

class FavoritesRepository
    with PresenceInfoDriftMapper, ContactsDriftMapper, FavoritesDriftMapper
    implements Refreshable {
  FavoritesRepository({
    required AppDatabase appDatabase,
    required api.WebtritApiClient apiClient,
    required ConnectivityService connectivityService,
    required String apiToken,
  }) : _appDatabase = appDatabase,
       _connectivityService = connectivityService,
       _apiClient = apiClient,
       _apiToken = apiToken;

  final AppDatabase _appDatabase;
  final ConnectivityService _connectivityService;
  final api.WebtritApiClient _apiClient;
  final String _apiToken;

  late final _dao = _appDatabase.favoritesV2Dao;
  String? _etag;

  Stream<List<FavoriteWithContact>> watchAllWithContacts() {
    return _dao.watchWithContacts().map((data) => data.map((e) => favoriteWithContactFromDrift(e)).toList());
  }

  Future<void> addByContact(ContactPhone contactPhone, Contact contact) async {
    final number = contactPhone.number;
    final sourceType = switch (contact.sourceType) {
      ContactSourceType.local => FavoriteSourceTypeData.device,
      ContactSourceType.external => FavoriteSourceTypeData.pbx,
    };
    final sourceId = contact.sourceId ?? contact.id.toString();
    final label = contactPhone.label;
    await _dao.add(number, sourceType, sourceId, label);

    final outboxEntry = FavoriteOutboxEntryData(
      action: FavoriteOutboxActionData.upsert,
      number: number,
      sourceType: sourceType,
      sourceId: sourceId,
      label: label,
      sendAttempts: 0,
      timestampUsec: DateTime.now().microsecondsSinceEpoch,
    );

    await _dao.setOutboxEntry(outboxEntry, replacePrevAction: true);

    final online = await _connectivityService.checkConnection();
    if (online) await _syncWithApi();
  }

  Future<void> removeByContact(ContactPhone contactPhone, Contact contact) async {
    final number = contactPhone.number;
    final sourceType = switch (contact.sourceType) {
      ContactSourceType.local => FavoriteSourceTypeData.device,
      ContactSourceType.external => FavoriteSourceTypeData.pbx,
    };
    await _dao.remove((number, sourceType));

    final outboxEntry = FavoriteOutboxEntryData(
      action: FavoriteOutboxActionData.delete,
      number: number,
      sourceType: sourceType,
      sendAttempts: 0,
      timestampUsec: DateTime.now().microsecondsSinceEpoch,
    );
    await _dao.setOutboxEntry(outboxEntry, replacePrevAction: true);

    final online = await _connectivityService.checkConnection();
    if (online) await _syncWithApi();
  }

  Future<void> remove(Favorite favorite) async {
    _dao.remove(favoriteKeyFromFavorite(favorite));

    final outboxEntry = FavoriteOutboxEntryData(
      action: FavoriteOutboxActionData.delete,
      number: favorite.number,
      sourceType: favoriteSourceTypeToDrift(favorite.sourceType),
      sendAttempts: 0,
      timestampUsec: DateTime.now().microsecondsSinceEpoch,
    );
    await _dao.setOutboxEntry(outboxEntry, replacePrevAction: true);

    final online = await _connectivityService.checkConnection();
    if (online) await _syncWithApi();
  }

  Future<void> shift(Favorite favorite, int position) async {
    _dao.shift(favoriteKeyFromFavorite(favorite), position);

    final outboxEntry = FavoriteOutboxEntryData(
      action: FavoriteOutboxActionData.upsert,
      number: favorite.number,
      sourceType: favoriteSourceTypeToDrift(favorite.sourceType),
      sourceId: favorite.sourceId,
      label: favorite.label,
      position: position,
      sendAttempts: 0,
      timestampUsec: DateTime.now().microsecondsSinceEpoch,
    );
    await _dao.setOutboxEntry(outboxEntry, replacePrevAction: true);

    final online = await _connectivityService.checkConnection();
    if (online) await _syncWithApi();
  }

  @override
  Future<void> refresh() {
    return _syncWithApi();
  }

  Future<void> _syncWithApi() async {
    final outbox = await _dao.getAllOutboxEntries();

    if (outbox.isEmpty) {
      try {
        final result = await _apiClient.getFavorites(_apiToken, ifNoneMatch: _etag);

        if (result.notModified) {
          _logger.fine('Favorites not modified since last sync');
          return;
        }

        final items = result.data!.items;
        await _dao.batchReplace(items.map(_mapApiToDrift).toList(), removePrevious: true);
        _etag = result.etag;
      } catch (e, s) {
        _logger.warning('Failed to pull remote data', e, s);
      }
    } else {
      _logger.info('Syncing ${outbox.length} favorite changes from outbox');
      try {
        final actions = outbox.map(_mapOutboxToApiAction).toList();
        final result = await _apiClient.batchSyncFavorites(_apiToken, actions);
        await Future.forEach(outbox, (e) => _dao.removeOutboxEntry(e.action, e.number, e.sourceType));
        await _dao.batchReplace(result.data.items.map(_mapApiToDrift).toList(), removePrevious: true);
        _etag = result.etag;
      } catch (e, s) {
        final outboxAfterAttempt = outbox.map((e) => e.copyWith(sendAttempts: e.sendAttempts + 1));
        for (var en in outboxAfterAttempt) {
          if (en.sendAttempts > 5) {
            _logger.warning('Dropping outbox entry after 5 attempts: ${en.number} (${en.sourceType})');
            await _dao.removeOutboxEntry(en.action, en.number, en.sourceType);
          } else {
            await _dao.setOutboxEntry(en);
          }
        }

        _logger.warning('Failed to sync favorites outbox', e, s);
      }
    }
  }

  FavoriteV2Data _mapApiToDrift(api.FavoriteItem f) => FavoriteV2Data(
    number: f.number,
    sourceType: FavoriteSourceTypeData.values.byName(f.sourceType.name),
    sourceId: f.sourceId,
    label: f.label,
    position: f.position,
  );

  api.FavoriteBatchAction _mapOutboxToApiAction(FavoriteOutboxEntryData e) => api.FavoriteBatchAction(
    action: api.FavoriteBatchActionType.values.byName(e.action.name),
    number: e.number,
    sourceType: api.FavoriteSourceType.values.byName(e.sourceType.name),
    sourceId: e.sourceId,
    label: e.label,
    position: e.position,
  );
}
