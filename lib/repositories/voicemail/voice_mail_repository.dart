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

class VoicemailRepositoryImpl with ContactsDriftMapper implements VoicemailRepository {
  VoicemailRepositoryImpl({
    required WebtritApiClient webtritApiClient,
    required String token,
    required AppDatabase appDatabase,
  })  : _webtritApiClient = webtritApiClient,
        _token = token,
        _appDatabase = appDatabase {
    _initialize();
  }

  final WebtritApiClient _webtritApiClient;
  final String _token;
  final AppDatabase _appDatabase;

  // Try actualize voicemail list on app start
  void _initialize() {
    _logger.info('VoicemailRepository initialized, fetching voicemails');
    unawaited(fetchVoicemails());
  }

  @override
  Future<List<Voicemail>> fetchVoicemails({String? localeCode}) async {
    final remoteItems = await _webtritApiClient.getUserVoicemailList(
      _token,
      locale: localeCode,
      options: RequestOptions.withNoRetries(),
    );

    final result = <Voicemail>[];

    for (final item in remoteItems.items) {
      final details = await _webtritApiClient.getUserVoicemail(
        _token,
        item.id,
        locale: localeCode,
        options: RequestOptions.withNoRetries(),
      );

      final voicemail = VoicemailData(
        id: item.id,
        date: item.date,
        duration: item.duration,
        sender: details.sender,
        receiver: details.receiver,
        seen: item.seen,
        size: item.size,
        type: item.type,
        attachmentPath: _webtritApiClient.getVoicemailAttachmentUrl(item.id),
      );

      try {
        await _appDatabase.voicemailDao.insertOrUpdateVoicemail(voicemail).timeout(const Duration(seconds: 5));
        _logger.info('Voicemail ${item.id} inserted/updated');
      } catch (e, s) {
        _logger.warning('insertOrUpdateVoicemail failed: $e\n$s');
      }
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
  Future<void> updateVoicemailSeenStatus(String messageId, bool seen, {String? localeCode}) async {
    _logger.info('updateVoicemailSeenStatus: $messageId, seen: $seen');

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

  // data.contact
  @override
  Stream<List<Voicemail>> watchVoicemails() {
    return _appDatabase.voicemailDao.watchVoicemailsWithContacts().map(
          (dataList) => dataList
              .map(
                (data) => Voicemail(
                  data.voicemail.id,
                  data.voicemail.date,
                  data.voicemail.duration,
                  data.voicemail.sender,
                  (data.contact != null ? contactFromDrift(data.contact!).maybeName : null) ?? data.voicemail.sender,
                  data.voicemail.receiver,
                  data.voicemail.seen,
                  data.voicemail.size,
                  data.voicemail.type,
                  data.voicemail.attachmentPath,
                ),
              )
              .toList(),
        );
  }

  @override
  Future<void> removeAllVoicemails() {
    return _appDatabase.voicemailDao.deleteAllVoicemails();
  }
}
