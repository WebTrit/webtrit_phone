import 'dart:async';

import 'package:logging/logging.dart';

import 'package:app_database/app_database.dart';
import 'package:app_transcription/app_transcription.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/transcription_model/transcription_model_repository.dart';
import 'package:webtrit_phone/app/session/session.dart';

/// Voicemail owns its transcription: the repository is also the
/// [TranscriptionModelRepository] of the voicemail transcription model, so
/// consumers deal with a single object.
abstract class VoicemailRepository implements Refreshable, TranscriptionModelRepository {
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

  Future<void> removeMultipleVoicemails(List<String> messagesIds);

  /// Returns `false` once the server has responded with [VoicemailNotConfiguredException]
  /// or [EndpointNotSupportedException], indicating that voicemail is permanently
  /// unavailable for this session.
  bool get isFeatureSupported;

  /// Number of voicemail records stored in the local database.
  Future<int> localRecordsCount();

  /// Removes only the locally cached voicemail records; the server copy stays
  /// and the list is fetched again on the next refresh.
  Future<void> wipeLocalRecords();

  /// True when the user may pick the on-device transcription model; false
  /// hides the model selection entirely.
  bool get canSelectTranscriptionModel;

  /// The app-config default model tier the override falls back to.
  String get defaultTranscriptionModel;
}

final _logger = Logger('VoicemailRepository');

class VoicemailRepositoryImpl
    with DialogInfoDriftMapper, PresenceInfoDriftMapper, ContactsDriftMapper, VoicemailMapper
    implements VoicemailRepository {
  VoicemailRepositoryImpl({
    required WebtritApiClient webtritApiClient,
    required String token,
    required AppDatabase appDatabase,
    SessionGuard? sessionGuard,
    MediaTranscriber? transcriber,
    TranscriptionModelRepository? transcriptionModelRepository,
    String defaultTranscriptionModel = 'base',
  }) : _sessionGuard = sessionGuard ?? const EmptySessionGuard(),
       _webtritApiClient = webtritApiClient,
       _token = token,
       _appDatabase = appDatabase,
       _transcriber = transcriber,
       _transcriptionModelRepository = transcriptionModelRepository,
       _defaultTranscriptionModel = defaultTranscriptionModel {
    _initialize();
  }

  final WebtritApiClient _webtritApiClient;
  final String _token;
  final AppDatabase _appDatabase;
  final SessionGuard _sessionGuard;

  /// Fire-and-forget hand-off to the transcription pool; the repository
  /// never observes the pool itself - results and lifecycle states arrive as
  /// database updates. Null when transcription is disabled.
  final MediaTranscriber? _transcriber;

  /// Persists the user's model override; null when the model is not user
  /// selectable (feature disabled, not local, or pinned by the brand).
  final TranscriptionModelRepository? _transcriptionModelRepository;
  final String _defaultTranscriptionModel;

  @override
  bool get canSelectTranscriptionModel => _transcriptionModelRepository != null && _transcriber != null;

  @override
  String get defaultTranscriptionModel => _defaultTranscriptionModel;

  @override
  String? getTranscriptionModel() => _transcriptionModelRepository?.getTranscriptionModel();

  /// Persists the override (null returns to the config default) and switches
  /// the transcription pool to it, which regenerates every transcript.
  @override
  Future<void> setTranscriptionModel(String? value) async {
    final transcriptionModelRepository = _transcriptionModelRepository;
    if (transcriptionModelRepository == null) return;

    await transcriptionModelRepository.setTranscriptionModel(value);
    _transcriber?.switchLocalModel(value);
  }

  @override
  Future<void> clear() => setTranscriptionModel(null);

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
  bool _featureSupported = true;

  @override
  bool get isFeatureSupported => _featureSupported;

  @override
  bool get isActive => _featureSupported;

  @override
  Future<int> localRecordsCount() => _appDatabase.voicemailDao.recordsCount();

  @override
  Future<void> wipeLocalRecords() async {
    final voicemails = await _appDatabase.voicemailDao.getAllVoicemails();
    await _appDatabase.voicemailDao.deleteAllVoicemails();

    // Per-item forget dequeues pending or in-flight pool work; the trailing
    // sweep clears any row that no longer had a cached voicemail.
    for (final voicemail in voicemails) {
      await _forgetVoicemailTranscription(voicemail.id);
    }
    await _appDatabase.transcriptionsDao.deleteAllForType(kVoicemailTranscriptionMediaType);
  }

  void _initialize() {
    _updatesController = StreamController<List<Voicemail>>.broadcast(onListen: _onListen, onCancel: _onCancel);

    // The database is the single feedback channel with the transcription
    // pool: any voice message without a transcription row (freshly fetched,
    // or wiped by a model switch) shows up on this watch and gets enqueued;
    // the pool dedups repeats and its lifecycle writes take the row out of
    // the watch, so emissions cannot loop.
    if (_transcriber != null) {
      _appDatabase.voicemailDao.watchVoicemailsMissingTranscription().listen(
        _enqueueVoicemails,
        onError: (Object e, StackTrace st) {
          _logger.warning('Pending transcriptions watch failed', e, st);
        },
      );
    }

    unawaited(
      fetchVoicemails().catchError(
        (Object e) {},
        test: (e) => e is VoicemailNotConfiguredException || e is EndpointNotSupportedException,
      ),
    );
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
    if (!_featureSupported) return;

    if (_fetchingCompleter?.isCompleted == false) {
      return _fetchingCompleter!.future;
    }

    _fetchingCompleter = Completer<void>();
    _fetchingCompleter!.future.ignore();

    try {
      /// Do not emit unknown status to show updating state, because it leads to UI flicker on SettingsScreen
      /// especially on android if user checks status bar and app changes its lifecycle from innactive to resumed (WT-1424)
      ///
      /// Add separate event if needed
      await _emitCachedVoicemails();

      final remoteItems = await _webtritApiClient.getUserVoicemailList(_token, locale: localeCode);

      for (final item in remoteItems.items) {
        final details = await _webtritApiClient.getUserVoicemail(_token, item.id, locale: localeCode);

        // Transcripts are produced locally and the remote payload never
        // carries them, so the upsert leaves the transcript columns untouched
        // on update (a read-then-write merge here would race the background
        // transcription sweep and could wipe a just-finished transcript).
        await _appDatabase.voicemailDao.upsertVoicemailFromRemote(
          voicemailToDrift(item, details, _webtritApiClient.getVoicemailAttachmentUrl(item.id)),
        );
      }

      _fetchingCompleter?.complete();

      unawaited(_enqueuePendingTranscriptions());
    } on UnauthorizedException catch (e) {
      _sessionGuard.onUnauthorized(e);
      rethrow;
    } catch (e, st) {
      final isExpected = e is VoicemailNotConfiguredException || e is EndpointNotSupportedException;
      _logger.warning('Failed to fetch voicemails', e, isExpected ? null : st);
      if (isExpected) _featureSupported = false;

      /// Revert to the actual cached status from database on failure
      await _emitCachedVoicemails();

      _fetchingCompleter?.completeError(e, st);
      rethrow;
    } finally {
      _fetchingCompleter = null;
    }
  }

  /// Enqueues voice messages that still need a transcript into the
  /// session-wide [TranscriptionService] pool and returns immediately; the
  /// service writes progress and results to the local database, so
  /// [watchVoicemails] listeners see every update live.
  ///
  /// The missing-transcription watch only covers rows that were never
  /// attempted; this fetch-time pass additionally retries messages rolled
  /// back to a null status by a transient failure (bounded to one attempt
  /// per fetch). [TranscriptStatus.unavailable] stays terminal.
  Future<void> _enqueuePendingTranscriptions() async {
    if (_transcriber == null) return;

    try {
      final pending = await _appDatabase.voicemailDao.getVoicemailsPendingTranscription(
        excludedStatus: TranscriptStatus.unavailable.name,
      );
      _enqueueVoicemails(pending);
    } catch (e, st) {
      // Runs unawaited; never let an error (e.g. a database closed by logout)
      // escape to the zone as an unhandled async error.
      _logger.warning('Failed to enqueue pending voicemail transcriptions', e, st);
    }
  }

  void _enqueueVoicemails(List<VoicemailData> voicemails) {
    final transcriber = _transcriber;
    if (transcriber == null) return;

    for (final voicemail in voicemails) {
      transcriber.enqueue(
        kVoicemailTranscriptionMediaType,
        voicemail.id,
        () => _webtritApiClient.getUserVoicemailAttachment(_token, voicemail.id, fileFormat: 'wav'),
      );
    }
  }

  /// Routes transcription cleanup through the pool when it is wired so a
  /// queued or in-flight item cannot resurrect the row of a deleted
  /// voicemail.
  Future<void> _forgetVoicemailTranscription(String messageId) async {
    final transcriber = _transcriber;
    if (transcriber != null) {
      await transcriber.forget(kVoicemailTranscriptionMediaType, messageId);
    } else {
      await _appDatabase.transcriptionsDao.deleteByMedia(kVoicemailTranscriptionMediaType, messageId);
    }
  }

  /// Retrieves local voicemails and pushes them to the stream controller.
  Future<void> _emitCachedVoicemails() async {
    final dataList = await _appDatabase.voicemailDao.getVoicemailsWithContacts();
    final items = dataList.map(_voicemailFromDriftWithContact).toList();

    if (items.isNotEmpty) {
      _updatesController?.add(items);
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
      await _forgetVoicemailTranscription(messageId);
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
        // removeVoicemail owns the local cleanup (voicemail row + queued or
        // stored transcription).
        await removeVoicemail(voicemail.id);
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
      unawaited(_webtritApiClient.updateUserVoicemail(_token, messageId, seen: seen, locale: localeCode));
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
  /// including changes to the `status` of individual voicemails.
  ///
  /// It internally depends on [watchVoicemails], and transforms the emitted list into a count
  /// of voicemails where `status` is not [ReadStatus.read].
  ///
  /// Returns a broadcast [Stream<int>] that can be safely listened to by multiple subscribers.
  @override
  Stream<int> watchUnreadVoicemailsCount() {
    return watchVoicemails().map((list) => list.where((v) => !v.status.isRead).length);
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

  Voicemail _voicemailFromDriftWithContact(VoicemailWithContact data, {ReadStatus? readStatus}) {
    final displayName = data.contact != null ? contactFromDrift(data.contact!).maybeName : null;

    return voicemailFromDrift(
      data.voicemail,
      displayName ?? data.voicemail.sender,
      transcription: data.transcription,
      readStatus: readStatus,
    );
  }

  @override
  Future<void> refresh() {
    return fetchVoicemails();
  }

  @override
  Future<void> removeMultipleVoicemails(List<String> messagesIds) async {
    if (_fetchingCompleter != null) {
      await _fetchingCompleter!.future;
    }

    for (final messageId in messagesIds) {
      try {
        // removeVoicemail owns the local cleanup (voicemail row + queued or
        // stored transcription).
        await removeVoicemail(messageId);
      } catch (e, st) {
        _logger.warning('Failed to remove voicemail with id $messageId', e, st);
        rethrow;
      }
    }
  }
}

/// A no-op implementation of [VoicemailRepository] used when voicemail functionality
/// is disabled or not available.
///
/// All methods in this repository perform no actions and return default or
/// empty values (e.g., `Future.value()`, `Stream.value(0)`, `Stream.value(const [])`).
///
/// This serves as a placeholder to prevent errors when other parts of the application
/// attempt to interact with the [VoicemailRepository] interface, even if the feature
/// is not enabled.

class EmptyVoicemailRepository implements VoicemailRepository {
  const EmptyVoicemailRepository();

  @override
  bool get isActive => false;

  @override
  Future<void> fetchVoicemails({String? localeCode}) => Future.value();

  @override
  Future<void> removeVoicemail(String messageId, {String? localeCode}) => Future.value();

  @override
  Future<void> removeAllVoicemails() => Future.value();

  @override
  Future<void> updateVoicemailSeenStatus(String messageId, bool seen, {String? localeCode}) => Future.value();

  @override
  Stream<int> watchUnreadVoicemailsCount() => Stream.value(0);

  @override
  Stream<List<Voicemail>> watchVoicemails() => Stream.value(const []);

  @override
  Future<void> refresh() => Future.value();

  @override
  Future<void> removeMultipleVoicemails(List<String> messagesIds) => Future.value();

  @override
  bool get isFeatureSupported => false;

  @override
  Future<int> localRecordsCount() => Future.value(0);

  @override
  Future<void> wipeLocalRecords() => Future.value();

  @override
  bool get canSelectTranscriptionModel => false;

  @override
  String get defaultTranscriptionModel => 'base';

  @override
  String? getTranscriptionModel() => null;

  @override
  Future<void> setTranscriptionModel(String? value) => Future.value();

  @override
  Future<void> clear() => Future.value();
}
