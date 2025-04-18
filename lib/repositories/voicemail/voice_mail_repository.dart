import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:path_provider/path_provider.dart';
import 'package:webtrit_api/webtrit_api.dart';
import 'package:webtrit_phone/models/models.dart';

import '../../data/data.dart';
import '../../mappers/drift/contacts_mapper.dart';

abstract class VoicemailRepository {
  Future<List<Voicemail>> getVoicemailList(Locale locale);

  Future<void> deleteVoicemail(String messageId, Locale locale);

  Future<void> delete();

  Future<void> updateVoicemailSeen(String messageId, bool seen, Locale locale);

  Future<Uint8List> getVoicemailAttachment(String messageId, {String? fileFormat, Locale? locale});

  Stream<List<Voicemail>> watchVoicemails();
}

class VoicemailRepositoryImpl with ContactsDriftMapper implements VoicemailRepository {
  VoicemailRepositoryImpl({
    required WebtritApiClient webtritApiClient,
    required String token,
    required AppDatabase appDatabase,
  })  : _webtritApiClient = webtritApiClient,
        _token = token,
        _appDatabase = appDatabase;

  final WebtritApiClient _webtritApiClient;
  final String _token;
  final AppDatabase _appDatabase;

  @override
  Future<List<Voicemail>> getVoicemailList(Locale locale) async {
    final remoteItems = await _webtritApiClient.getUserVoicemailList(
      _token,
      locale: locale.toString(),
      options: RequestOptions.withNoRetries(),
    );

    final result = <Voicemail>[];

    for (final item in remoteItems.items) {
      final details = await _webtritApiClient.getUserVoicemail(
        _token,
        item.id,
        locale: locale.toString(),
        options: RequestOptions.withNoRetries(),
      );

      // https://core1.demo.webtrit.com/api/v1/user/voicemails/2066/attachment?file_format=mp3
      final voicemail = VoicemailData(
        id: int.parse(item.id),
        date: item.date,
        duration: item.duration,
        sender: details.sender,
        receiver: details.receiver,
        seen: item.seen,
        size: item.size,
        type: item.type,
        // TODO(Serdun):
        attachmentPath: "https://core1.demo.webtrit.com/api/v1/user/voicemails/${item.id}/attachment?file_format=mp3",
      );

      try {
        await _appDatabase.voicemailDao.insertOrUpdateVoicemail(voicemail).timeout(const Duration(seconds: 5));
        print("✅ inserted or updated");
      } catch (e, s) {
        print("❌ insertOrUpdateVoicemail failed: $e\n$s");
      }
    }

    return result;
  }

  @override
  Future<void> deleteVoicemail(String messageId, Locale locale) async {
    await _webtritApiClient.deleteUserVoicemail(
      _token,
      messageId,
      locale: locale.toString(),
      options: RequestOptions.withNoRetries(),
    );

    await _appDatabase.voicemailDao.deleteVoicemailById(int.parse(messageId));
  }

  @override
  Future<void> updateVoicemailSeen(String messageId, bool seen, Locale locale) async {
    await _webtritApiClient.updateUserVoicemail(
      _token,
      messageId,
      seen: seen,
      locale: locale.toString(),
      options: RequestOptions.withNoRetries(),
    );

    await _appDatabase.voicemailDao.updateVoicemail(
      VoicemailDataCompanion(
        id: Value(int.parse(messageId)),
        seen: Value(seen),
      ),
    );
  }

  @override
  Future<Uint8List> getVoicemailAttachment(
    String messageId, {
    String? fileFormat,
    Locale? locale,
  }) {
    return _webtritApiClient.getUserVoicemailAttachment(
      _token,
      messageId,
      fileFormat: fileFormat,
      locale: locale?.toString(),
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
                  data.voicemail.receiver,
                  (data.contact != null ? contactFromDrift(data.contact!).maybeName : null) ?? data.voicemail.receiver,
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
  Future<void> delete() {
    return _appDatabase.voicemailDao.deleteAllVoicemails();
  }
}
