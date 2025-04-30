import 'dart:async';
import 'dart:typed_data';

import 'package:logging/logging.dart';

import 'package:app_database/app_database.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

abstract class VoicemailRepository {
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

class VoicemailRepositoryImpl with ContactsDriftMapper, VoicemailMapper implements VoicemailRepository {
  VoicemailRepositoryImpl({
    required WebtritApiClient webtritApiClient,
    required String token,
    required AppDatabase appDatabase,
    this.repositoryOptions = const RepositoryOptions(),
  })  : _webtritApiClient = webtritApiClient,
        _token = token,
        _appDatabase = appDatabase {
    _initialize();
  }

  final WebtritApiClient _webtritApiClient;
  final String _token;
  final AppDatabase _appDatabase;
  final RepositoryOptions repositoryOptions;

  // If the repository is disabled, the stream controller is not initialized.
  // In such cases, subscribers will receive an empty stream instead.
  StreamController<List<Voicemail>>? _updatesController;
  StreamSubscription? _databaseSubscription;
  Timer? _pollTimer;

  void _initialize() {
    if (repositoryOptions.shouldOperate) {
      _updatesController = StreamController<List<Voicemail>>.broadcast(
        onListen: _onListen,
        onCancel: _onCancel,
      );

      unawaited(fetchVoicemails());
    } else {
      _logger.warning('Voicemail repository is not active');
    }
  }

  // Listener for the database changes and add them to the stream
  void _onListen() {
    _databaseSubscription = _appDatabase.voicemailDao.watchVoicemailsWithContacts().listen((dataList) {
      final items = dataList.map(_voicemailFromDriftWithContact).toList();
      _updatesController?.add(items);
    });

    // If polling is enabled, start the timer to fetch voicemails periodically
    if (repositoryOptions.polling) {
      _pollTimer = Timer.periodic(repositoryOptions.pollPeriod, (_) => _fetchFromServer().ignore());
    }
  }

  // Fetch voicemails from the server and add them to database
  Future<void> _fetchFromServer() async {
    try {
      await fetchVoicemails();
    } catch (e, st) {
      _updatesController?.addError(e, st);
    }
  }

// Cancel the database subscription and the timer when there are no listeners
  void _onCancel() {
    _databaseSubscription?.cancel();
    _pollTimer?.cancel();
  }

  // Fetch voicemails from the server and add them to the database
  @override
  Future<void> fetchVoicemails({String? localeCode}) async {
    final cachedVoicemails = await _getCachedVoicemails(localeCode: localeCode);
    if (cachedVoicemails.isNotEmpty) {
      _updatesController?.add(cachedVoicemails);
    }

    final remoteItems = await _webtritApiClient.getUserVoicemailList(
      _token,
      locale: localeCode,
    );

    for (final userVoicemailItem in remoteItems.items) {
      final userVoicemailDetails = await _webtritApiClient.getUserVoicemail(
        _token,
        userVoicemailItem.id,
        locale: localeCode,
      );

      await _appDatabase.voicemailDao.insertOrUpdateVoicemail(voicemailToDrift(
        userVoicemailItem,
        userVoicemailDetails,
        _webtritApiClient.getVoicemailAttachmentUrl(userVoicemailItem.id),
      ));
    }
  }

  @override
  Future<void> removeVoicemail(String messageId, {String? localeCode}) async {
    await _webtritApiClient.deleteUserVoicemail(
      _token,
      messageId,
      locale: localeCode,
      options: RequestOptions.withNoRetries(),
    );

    await _appDatabase.voicemailDao.deleteVoicemailById(messageId);
  }

  @override
  Future<void> removeAllVoicemails() async {
    final allVoicemails = await _appDatabase.voicemailDao.getAllVoicemails();

    for (final voicemail in allVoicemails) {
      try {
        await removeVoicemail(voicemail.id);
      } catch (e, st) {
        _logger.warning('Failed to remove voicemail with id ${voicemail.id}', e, st);
      }
    }

    await _appDatabase.voicemailDao.deleteAllVoicemails();
  }

  /// Optimistically updates the voicemail `seen` status in the local database,
  /// then attempts to sync this change with the remote server.
  ///
  /// If the remote update fails, the local change is rolled back to preserve consistency.
  @override
  Future<void> updateVoicemailSeenStatus(String messageId, bool seen, {String? localeCode}) async {
    final previous = await _appDatabase.voicemailDao.getVoicemailById((messageId));
    if (previous == null) return;

    final previousVoicemail = VoicemailDataCompanion(id: Value(previous.id), seen: Value(seen));
    await _appDatabase.voicemailDao.updateVoicemail(previousVoicemail);

    try {
      await _webtritApiClient.updateUserVoicemail(_token, messageId, seen: seen, locale: localeCode);
    } catch (e) {
      await _appDatabase.voicemailDao.updateVoicemail(previousVoicemail);
      rethrow;
    }
  }

  @override
  Stream<int> watchUnreadVoicemailsCount() {
    return watchVoicemails().map((list) => list.where((v) => !v.seen).length);
  }

  @override
  Stream<List<Voicemail>> watchVoicemails() {
    return _updatesController?.stream ?? const Stream.empty();
  }

  Voicemail _voicemailFromDriftWithContact(VoicemailWithContact data) {
    final displayName = data.contact != null ? contactFromDrift(data.contact!).maybeName : null;

    return voicemailFromDrift(
      data.voicemail,
      displayName ?? data.voicemail.sender,
    );
  }

  Future<List<Voicemail>> _getCachedVoicemails({String? localeCode}) {
    return _appDatabase.voicemailDao.getVoicemailsWithContacts().then((dataList) {
      return dataList.map(_voicemailFromDriftWithContact).toList();
    });
  }
}
