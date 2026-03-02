import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/common/refreshable.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/services/services.dart';

import 'favorites_local_data_source.dart';
import 'favorites_remote_data_source.dart';

final _logger = Logger('FavoritesRepository');

abstract class FavoritesRepository {
  /// Watch the list of favorites with corresponding contact information.
  /// The list is ordered by favorite position.
  Stream<List<FavoriteWithContact>> watchAllWithContacts();

  /// Add new favorite corresponding to the given contact information.
  Future<void> addByContact(ContactPhone contactPhone, Contact contact);

  /// Remove the favorite corresponding to the given contact phone, if exists
  Future<void> removeByContact(ContactPhone contactPhone, Contact contact);

  /// Remove the given favorite.
  Future<void> remove(Favorite favorite);

  /// Shift the given favorite to the new position, adjusting positions of other favorites as needed.
  Future<void> shift(Favorite favorite, int position);
}

class FavoritesRepositorySyncableImpl implements FavoritesRepository, Refreshable {
  FavoritesRepositorySyncableImpl({
    required FavoritesLocalDataSource localDataSource,
    required FavoritesRemoteDataSource remoteDataSource,
    required ConnectivityService connectivityService,
  }) : _localRepository = localDataSource,
       _remoteRepository = remoteDataSource,
       _connectivityService = connectivityService;

  final FavoritesLocalDataSource _localRepository;
  final FavoritesRemoteDataSource _remoteRepository;
  final ConnectivityService _connectivityService;

  // Store the ETag of the last successfully pulled favorites
  // list to optimize network usage if nothing has changed on the server.
  String? _etag;

  @override
  Stream<List<FavoriteWithContact>> watchAllWithContacts() {
    return _localRepository.watchAllWithContacts();
  }

  @override
  Future<void> addByContact(ContactPhone contactPhone, Contact contact) async {
    final favorite = Favorite(
      number: contactPhone.number,
      sourceType: _favoriteSourceTypeFromContact(contact.sourceType),
      sourceId: contact.sourceId ?? contact.id.toString(),
      label: contactPhone.label,
      position: 0,
    );

    await _localRepository.add(favorite);

    await _localRepository.setOutboxAction(
      FavoriteOutboxAction(
        action: FavoriteOutboxActionType.upsert,
        number: favorite.number,
        sourceType: favorite.sourceType,
        sourceId: favorite.sourceId,
        label: favorite.label,
        sendAttempts: 0,
        timestampUsec: DateTime.now().microsecondsSinceEpoch,
      ),
      replacePrevAction: true,
    );

    await _syncIfOnline();
  }

  @override
  Future<void> removeByContact(ContactPhone contactPhone, Contact contact) async {
    final favorite = Favorite(
      number: contactPhone.number,
      sourceType: _favoriteSourceTypeFromContact(contact.sourceType),
      sourceId: contact.sourceId ?? contact.id.toString(),
      label: contactPhone.label,
      position: 0,
    );

    await _localRepository.remove(favorite);

    await _localRepository.setOutboxAction(
      FavoriteOutboxAction(
        action: FavoriteOutboxActionType.delete,
        number: favorite.number,
        sourceType: favorite.sourceType,
        sendAttempts: 0,
        timestampUsec: DateTime.now().microsecondsSinceEpoch,
      ),
      replacePrevAction: true,
    );

    await _syncIfOnline();
  }

  @override
  Future<void> remove(Favorite favorite) async {
    await _localRepository.remove(favorite);

    await _localRepository.setOutboxAction(
      FavoriteOutboxAction(
        action: FavoriteOutboxActionType.delete,
        number: favorite.number,
        sourceType: favorite.sourceType,
        sendAttempts: 0,
        timestampUsec: DateTime.now().microsecondsSinceEpoch,
      ),
      replacePrevAction: true,
    );

    await _syncIfOnline();
  }

  @override
  Future<void> shift(Favorite favorite, int position) async {
    await _localRepository.shift(favorite, position);

    await _localRepository.setOutboxAction(
      FavoriteOutboxAction(
        action: FavoriteOutboxActionType.upsert,
        number: favorite.number,
        sourceType: favorite.sourceType,
        sourceId: favorite.sourceId,
        label: favorite.label,
        position: position,
        sendAttempts: 0,
        timestampUsec: DateTime.now().microsecondsSinceEpoch,
      ),
      replacePrevAction: true,
    );

    await _syncIfOnline();
  }

  @override
  Future<void> refresh() {
    return _sync();
  }

  FavoriteSourceType _favoriteSourceTypeFromContact(ContactSourceType sourceType) {
    return switch (sourceType) {
      ContactSourceType.local => FavoriteSourceType.device,
      ContactSourceType.external => FavoriteSourceType.pbx,
    };
  }

  Future<void> _syncIfOnline() async {
    final online = await _connectivityService.checkConnection();
    if (online) await _sync();
  }

  Future<void> _sync() async {
    final outbox = await _localRepository.getAllOutboxActions();
    if (outbox.isEmpty) {
      await _pullRemoteFavorites();
    } else {
      await _syncOutboxActions(outbox);
    }
  }

  Future<void> _pullRemoteFavorites() async {
    try {
      final result = await _remoteRepository.getFavorites(ifNoneMatch: _etag);
      if (result.notModified) {
        _logger.fine('Favorites not modified since last sync');
        return;
      }

      await _localRepository.batchReplace(result.items, removePrevious: true);
      _etag = result.etag;
    } catch (e, s) {
      _logger.warning('Failed to pull remote data', e, s);
    }
  }

  Future<void> _syncOutboxActions(List<FavoriteOutboxAction> outbox) async {
    _logger.info('Syncing ${outbox.length} favorite changes from outbox');
    try {
      final result = await _remoteRepository.batchSyncFavorites(outbox);
      await Future.forEach(outbox, _localRepository.removeOutboxAction);
      await _localRepository.batchReplace(result.items, removePrevious: true);
      _etag = result.etag;
    } catch (e, s) {
      await _handleOutboxSyncFailure(outbox);
      _logger.warning('Failed to sync favorites outbox', e, s);
    }
  }

  Future<void> _handleOutboxSyncFailure(List<FavoriteOutboxAction> outbox) async {
    final outboxAfterAttempt = outbox.map((e) => e.copyWith(sendAttempts: e.sendAttempts + 1));
    for (final action in outboxAfterAttempt) {
      if (action.sendAttempts > 5) {
        _logger.warning('Dropping outbox entry after 5 attempts: ${action.number} (${action.sourceType})');
        await _localRepository.removeOutboxAction(action);
      } else {
        await _localRepository.setOutboxAction(action);
      }
    }
  }
}
