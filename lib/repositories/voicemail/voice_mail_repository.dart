import 'dart:async';
import 'dart:typed_data';

import 'package:logging/logging.dart';

import 'package:app_database/app_database.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

abstract class VoicemailRepository {
  Future<List<Voicemail>> fetchVoicemails({String? localeCode});

  Future<void> removeVoicemail(String messageId, {String? localeCode});

  Future<void> removeAllVoicemails();

  Future<void> updateVoicemailSeenStatus(String messageId, bool seen, {String? localeCode});

  Stream<int> watchUnreadVoicemailsCount();

  Future<Uint8List> fetchVoicemailAttachment(String messageId, {String? fileFormat, String? localeCode});

  Stream<List<Voicemail>> watchVoicemails();
}

final _logger = Logger('VoicemailRepository');

class VoicemailRepositoryImpl with ContactsDriftMapper, VoicemailMapper implements VoicemailRepository {
  VoicemailRepositoryImpl({
    required WebtritApiClient webtritApiClient,
    required String token,
    required AppDatabase appDatabase,
    this.polling = true,
    this.pollPeriod = const Duration(minutes: 5),
  })  : _webtritApiClient = webtritApiClient,
        _token = token,
        _appDatabase = appDatabase {
    _initialize();
  }

  final WebtritApiClient _webtritApiClient;
  final String _token;
  final AppDatabase _appDatabase;
  final bool polling;
  final Duration pollPeriod;

  late final StreamController<List<Voicemail>> _updatesController;
  StreamSubscription? _databaseSubscription;
  Timer? _pollTimer;

  Stream<List<Voicemail>> get voicemailUpdates => _updatesController.stream;

  void _initialize() {
    _updatesController = StreamController<List<Voicemail>>.broadcast(
      onListen: _onListen,
      onCancel: _onCancel,
    );

    unawaited(fetchVoicemails());
  }

  // Listener for the database changes and add them to the stream
  void _onListen() {
    _databaseSubscription = _appDatabase.voicemailDao.watchVoicemailsWithContacts().listen((dataList) {
      final items = dataList.map(_voicemailFromDriftWithContact).toList();
      _updatesController.add(items);
    });

    // If polling is enabled, start the timer to fetch voicemails periodically
    if (polling) {
      _pollTimer = Timer.periodic(pollPeriod, (_) => _fetchFromServer().ignore());
    }
  }

  // Fetch voicemails from the server and add them to database
  Future<void> _fetchFromServer() async {
    try {
      await fetchVoicemails();
    } catch (e, st) {
      _updatesController.addError(e, st);
    }
  }

// Cancel the database subscription and the timer when there are no listeners
  void _onCancel() {
    _databaseSubscription?.cancel();
    _pollTimer?.cancel();
  }

  // Fetch voicemails from the server and add them to the database
  @override
  Future<List<Voicemail>> fetchVoicemails({String? localeCode}) async {
    final remoteItems = await _webtritApiClient.getUserVoicemailList(
      _token,
      locale: localeCode,
    );

    final result = <Voicemail>[];

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

    return result;
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

  @override
  Future<void> updateVoicemailSeenStatus(String messageId, bool seen, {String? localeCode}) async {
    await _webtritApiClient.updateUserVoicemail(
      _token,
      messageId,
      seen: seen,
      locale: localeCode,
      options: RequestOptions.withNoRetries(),
    );

    await _appDatabase.voicemailDao.updateVoicemail(
      VoicemailDataCompanion(
        id: Value(messageId),
        seen: Value(seen),
      ),
    );
  }

  @override
  Stream<int> watchUnreadVoicemailsCount() {
    return watchVoicemails().map((list) => list.where((v) => !v.seen).length);
  }

  @override
  Future<Uint8List> fetchVoicemailAttachment(
    String messageId, {
    String? fileFormat,
    String? localeCode,
  }) {
    return _webtritApiClient.getUserVoicemailAttachment(
      _token,
      messageId,
      fileFormat: fileFormat,
      locale: localeCode,
      options: RequestOptions.withNoRetries(),
    );
  }

  @override
  Stream<List<Voicemail>> watchVoicemails() {
    return voicemailUpdates;
  }

  Voicemail _voicemailFromDriftWithContact(VoicemailWithContact data) {
    final displayName = data.contact != null ? contactFromDrift(data.contact!).maybeName : null;

    return voicemailFromDrift(
      data.voicemail,
      displayName ?? data.voicemail.sender,
    );
  }
}
