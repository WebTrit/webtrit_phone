import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:path_provider/path_provider.dart';
import 'package:webtrit_api/webtrit_api.dart';
import 'package:webtrit_phone/models/models.dart';

import '../../data/data.dart';

abstract class VoicemailRepository {
  Future<List<Voicemail>> getVoicemailList(Locale locale);

  Future<void> deleteVoicemail(String messageId, Locale locale);

  Future<void> updateVoicemailSeen(String messageId, bool seen, Locale locale);

  Future<Uint8List> getVoicemailAttachment(String messageId, {String? fileFormat, Locale? locale});

  Future<String> getOrSaveVoicemailAttachmentFile(String messageId);

  Stream<List<Voicemail>> watchVoicemails();
}

class VoicemailRepositoryImpl implements VoicemailRepository {
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

      final path = await getOrSaveVoicemailAttachmentFile(item.id);

      final voicemail = VoicemailData(
        id: int.parse(item.id),
        date: item.date,
        duration: item.duration,
        sender: details.sender,
        receiver: details.receiver,
        seen: item.seen,
        size: item.size,
        type: item.type,
        attachmentPath: path,
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

  @override
  Future<String> getOrSaveVoicemailAttachmentFile(String messageId) async {
    return "test";
    // final filename = 'voicemail_$messageId.wav';
    // final dir = await getTemporaryDirectory();
    // final file = File('${dir.path}/$filename');
    //
    // if (await file.exists()) {
    //   return file.path;
    // }
    //
    // final rawBytes = await getVoicemailAttachment(messageId);
    // await file.writeAsBytes(rawBytes, flush: true);
    //
    // return file.path;
  }

  @override
  Stream<List<Voicemail>> watchVoicemails() {
    return _appDatabase.voicemailDao.watchAllVoicemails().map(
          (dataList) => dataList
              .map(
                (data) => Voicemail(
                  data.id,
                  data.date,
                  data.duration,
                  data.sender,
                  data.receiver,
                  data.seen,
                  data.size,
                  data.type,
                  [data.attachmentPath],
                ),
              )
              .toList(),
        );
  }
}
