import 'dart:async';

import 'package:logging/logging.dart';

import 'package:app_database/app_database.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/app/session/session.dart';

abstract class VoicemailRepository implements Refreshable {
  /// Fetches voicemails from the remote server and updates the local database.
  ///
  /// If [localeCode] is provided, it will be used to localize the request.
  /// This method does not return the fetched data directly. Instead, updates are
  /// reflected in [watchVoicemails].
  ///
  /// Additionally, any existing cached voicemails are immediately emitted to the stream,
  /// triggering all active [watchVoicemails] listeners before the remote fetch completes.
  Future<void> fetchVoicemails({String? localeCode});

  /// Removes a voicemail with the specified [messageId] from both the remote server and the local database.
  ///
  /// If [localeCode] is provided, it will be used in the API request.
  /// Throws an error if the deletion fails on the remote server.
  Future<void> removeVoicemail(String messageId, {String? localeCode});

  /// Removes all voicemails from both the remote server and the local database.
  ///
  /// Any errors that occur during remote deletions are logged but do not interrupt the process.
  Future<void> removeAllVoicemails();

  /// Updates the seen status of the voicemail with the given [messageId].
  ///
  /// The new [seen] value will be sent to the remote server and applied to the local database.
  /// If [localeCode] is provided, it will be used for the API request.
  Future<void> updateVoicemailSeenStatus(String messageId, bool seen, {String? localeCode});

  /// Watches the count of unread voicemails in the local database.
  ///
  /// Emits a new value whenever the underlying data changes.
  Stream<int> watchUnreadVoicemailsCount();

  /// Watches the list of voicemails from the local database.
  ///
  /// Emits updates whenever the voicemail list changes.
  /// If the repository is disabled, an empty stream is returned.
  Stream<List<Voicemail>> watchVoicemails();
}

final _logger = Logger('VoicemailRepository');

class VoicemailRepositoryImpl
    with PresenceInfoDriftMapper, ContactsDriftMapper, VoicemailMapper
    implements VoicemailRepository {
  VoicemailRepositoryImpl({
    required WebtritApiClient webtritApiClient,
    required String token,
    required AppDatabase appDatabase,
    SessionGuard? sessionGuard,
  }) : _sessionGuard = sessionGuard ?? const EmptySessionGuard(),
       _webtritApiClient = webtritApiClient,
       _token = token,
       _appDatabase = appDatabase {
    _initialize();
  }

  final WebtritApiClient _webtritApiClient;
  final String _token;
  final AppDatabase _appDatabase;
  final SessionGuard _sessionGuard;

  // If the repository is disabled, the stream controller is not initialized.
  // In such cases, subscribers will receive an empty stream instead.
  StreamController<List<Voicemail>>? _updatesController;
  StreamSubscription? _databaseSubscription;

  /// A [Completer] used to coordinate access to the ongoing [fetchVoicemails] operation.
  ///
  /// When [fetchVoicemails] is in progress, this completer is non-null and its [future]
  /// can be awaited to ensure that no other operations (such as updating or deleting voicemails)
  /// interfere with the fetch process.
  ///
  /// Once the fetch completes—successfully or with an error—the completer is completed
  /// and reset to `null`.
  ///
  /// This mechanism helps to enforce sequential consistency across local/remote voicemail state updates.
  Completer<void>? _fetchingCompleter;

  void _initialize() {
    _updatesController = StreamController<List<Voicemail>>.broadcast(onListen: _onListen, onCancel: _onCancel);

    unawaited(fetchVoicemails());
  }

  void _onListen() {
    _databaseSubscription = _appDatabase.voicemailDao.watchVoicemailsWithContacts().listen((dataList) {
      final items = dataList.map(_voicemailFromDriftWithContact).toList();
      _updatesController?.add(items);
    });
  }

  void _onCancel() {
    _databaseSubscription?.cancel();
  }

  /// Fetches the latest voicemails from the remote server and synchronizes them with the local database.
  ///
  /// If a fetch is already in progress, this method returns the same [Future] to avoid duplicate requests
  /// and ensure data consistency. This is coordinated using an internal [_fetchingCompleter].
  ///
  /// ## Behavior:
  /// - Immediately emits any cached voicemails from the local database to [watchVoicemails] listeners.
  /// - Then fetches the voicemail list from the remote server using [getUserVoicemailList].
  /// - For each remote item, retrieves detailed metadata using [getUserVoicemail],
  ///   and stores it in the local database via [insertOrUpdateVoicemail].
  ///
  /// On completion, listeners subscribed to [watchVoicemails] will receive updated data.
  /// If an error occurs during remote fetching, the [_fetchingCompleter] completes with error
  /// and the exception is rethrown to the caller.
  ///
  /// [localeCode] – optional locale parameter to localize API responses.
  ///
  /// Throws an exception if the remote request fails.
  @override
  Future<void> fetchVoicemails({String? localeCode}) async {
    if (_fetchingCompleter?.isCompleted == false) {
      return _fetchingCompleter!.future;
    }

    _fetchingCompleter = Completer<void>();

    try {
      final cachedVoicemails = await _appDatabase.voicemailDao.getVoicemailsWithContacts().then((dataList) {
        return dataList.map(_voicemailFromDriftWithContact).toList();
      });

      if (cachedVoicemails.isNotEmpty) {
        _updatesController?.add(cachedVoicemails);
      }

      final remoteItems = await _webtritApiClient.getUserVoicemailList(_token, locale: localeCode);

      for (final item in remoteItems.items) {
        final details = await _webtritApiClient.getUserVoicemail(_token, item.id, locale: localeCode);

        await _appDatabase.voicemailDao.insertOrUpdateVoicemail(
          voicemailToDrift(item, details, _webtritApiClient.getVoicemailAttachmentUrl(item.id)),
        );
      }

      _fetchingCompleter?.complete();
    } on UnauthorizedException catch (e) {
      _sessionGuard.onUnauthorized(e);
      rethrow;
    } catch (e, st) {
      _logger.warning('Failed to fetch voicemails', e, st);
      _fetchingCompleter?.completeError(e, st);
      rethrow;
    } finally {
      _fetchingCompleter = null;
    }
  }

  /// Removes a specific voicemail from both the remote server and the local database.
  ///
  /// If a [fetchVoicemails] operation is currently active, this method waits for it to complete
  /// before proceeding, ensuring no concurrent modifications to the same data set.
  ///
  /// The voicemail is first deleted from the remote server. If that succeeds,
  /// it is then removed from the local database.
  ///
  /// Throws an error if the remote deletion fails. The local record remains untouched in that case.
  ///
  /// [messageId] – the ID of the voicemail to remove.
  /// [localeCode] – optional locale code for the API request.
  @override
  Future<void> removeVoicemail(String messageId, {String? localeCode}) async {
    if (_fetchingCompleter != null) {
      await _fetchingCompleter!.future;
    }

    try {
      await _webtritApiClient.deleteUserVoicemail(
        _token,
        messageId,
        locale: localeCode,
        options: RequestOptions.withNoRetries(),
      );

      await _appDatabase.voicemailDao.deleteVoicemailById(messageId);
    } on UnauthorizedException catch (e) {
      _sessionGuard.onUnauthorized(e);
      rethrow;
    }
  }

  /// Removes all voicemails from both the remote server and the local database.
  ///
  /// If a [fetchVoicemails] operation is currently in progress, this method waits for it
  /// to complete before proceeding to avoid inconsistencies during concurrent data sync.
  ///
  /// For each voicemail:
  /// - Attempts to delete it remotely via [removeVoicemail].
  /// - Logs a warning if the remote deletion fails.
  ///
  /// After attempting remote deletions, forcibly clears all local voicemail records
  /// regardless of remote operation results.
  ///
  /// This approach guarantees that local state is reset even if remote sync is partially successful.
  @override
  Future<void> removeAllVoicemails() async {
    if (_fetchingCompleter != null) {
      await _fetchingCompleter!.future;
    }

    final allVoicemails = await _appDatabase.voicemailDao.getAllVoicemails();

    for (final voicemail in allVoicemails) {
      try {
        await removeVoicemail(voicemail.id);
        await _appDatabase.voicemailDao.deleteVoicemailById(voicemail.id);
      } catch (e, st) {
        _logger.warning('Failed to remove voicemail with id ${voicemail.id}', e, st);
        rethrow;
      }
    }
  }

  /// Updates the `seen` status of a voicemail, ensuring consistency with any ongoing fetch operation.
  ///
  /// If [fetchVoicemails] is currently in progress, this method waits for it to complete
  /// before proceeding. This guarantees sequential consistency and avoids conflicts
  /// between reading/updating local voicemail state during synchronization.
  ///
  /// The update is applied optimistically to the local database first, and then propagated
  /// to the remote server. If the remote update fails, the local change is reverted to preserve integrity.
  ///
  /// Throws an error if the remote update fails after the optimistic local update.
  ///
  /// [messageId] – the ID of the voicemail to update.
  /// [seen] – the new seen status to apply.
  /// [localeCode] – optional locale code for the API request.
  @override
  Future<void> updateVoicemailSeenStatus(String messageId, bool seen, {String? localeCode}) async {
    if (_fetchingCompleter != null) {
      await _fetchingCompleter!.future;
    }

    final previous = await _appDatabase.voicemailDao.getVoicemailById((messageId));
    if (previous == null) return;

    final previousVoicemail = VoicemailDataCompanion(id: Value(previous.id), seen: Value(seen));
    await _appDatabase.voicemailDao.updateVoicemail(previousVoicemail);

    try {
      await _webtritApiClient.updateUserVoicemail(_token, messageId, seen: seen, locale: localeCode);
    } on UnauthorizedException catch (e) {
      _sessionGuard.onUnauthorized(e);
      rethrow;
    } catch (e) {
      await _appDatabase.voicemailDao.updateVoicemail(previousVoicemail);
      rethrow;
    }
  }

  /// Watches the number of voicemails that are currently marked as unread.
  ///
  /// This stream emits a new integer value every time the underlying voicemail list changes,
  /// including changes to the `seen` status of individual voicemails.
  ///
  /// It internally depends on [watchVoicemails], and transforms the emitted list into a count
  /// of voicemails where `seen == false`.
  ///
  /// Returns a broadcast [Stream<int>] that can be safely listened to by multiple subscribers.
  @override
  Stream<int> watchUnreadVoicemailsCount() {
    return watchVoicemails().map((list) => list.where((v) => !v.seen).length);
  }

  /// Watches the list of voicemails currently stored in the local database.
  ///
  /// Emits the full list of [Voicemail] objects whenever:
  /// - the database content changes (insert/update/delete),
  /// - or the repository pushes cached/remote updates.
  ///
  /// If the repository is disabled (e.g. due to feature flag or configuration),
  /// returns an empty stream that never emits values.
  ///
  /// Returns a broadcast [Stream<List<Voicemail>>], or an empty stream if disabled.
  @override
  Stream<List<Voicemail>> watchVoicemails() {
    return _updatesController?.stream ?? const Stream.empty();
  }

  Voicemail _voicemailFromDriftWithContact(VoicemailWithContact data) {
    final displayName = data.contact != null ? contactFromDrift(data.contact!).maybeName : null;

    return voicemailFromDrift(data.voicemail, displayName ?? data.voicemail.sender);
  }

  @override
  Future<void> refresh() {
    return fetchVoicemails();
  }
}
