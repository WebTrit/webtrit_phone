import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:path_provider/path_provider.dart';
import 'package:webtrit_api/webtrit_api.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/mappers/mappers.dart';

abstract class VoicemailRepository {
  Future<List<Voicemail>> getVoicemailList(Locale locale);

  // Future<UserVoicemail> getVoicemail(String messageId, Locale locale);

  Future<void> deleteVoicemail(String messageId, Locale locale);

  Future<void> updateVoicemailSeen(String messageId, bool seen, Locale locale);

  Future<Uint8List> getVoicemailAttachment(String messageId, {String? fileFormat, Locale? locale});

  Future<String> getOrSaveVoicemailAttachmentFile(String messageId);
}

class VoicemailRepositoryImpl implements VoicemailRepository {
  VoicemailRepositoryImpl({
    required WebtritApiClient webtritApiClient,
    required String token,
  })  : _webtritApiClient = webtritApiClient,
        _token = token;

  final WebtritApiClient _webtritApiClient;
  final String _token;

  // @override
  // Future<List<UserVoicemailItem>> getVoicemailList(Locale locale) async {
  //   final response = await _webtritApiClient.getUserVoicemailList(
  //     _token,
  //     locale: locale.toString(),
  //     options: RequestOptions.withNoRetries(),
  //   );
  //   return response.items;
  // }
  //
  // @override
  // Future<UserVoicemail> getVoicemail(String messageId, Locale locale) {
  //   return _webtritApiClient.getUserVoicemail(
  //     _token,
  //     messageId,
  //     locale: locale.toString(),
  //     options: RequestOptions.withNoRetries(),
  //   );
  // }

  @override
  Future<void> deleteVoicemail(String messageId, Locale locale) {
    return _webtritApiClient.deleteUserVoicemail(
      _token,
      messageId,
      locale: locale.toString(),
      options: RequestOptions.withNoRetries(),
    );
  }

  @override
  Future<void> updateVoicemailSeen(String messageId, bool seen, Locale locale) {
    return _webtritApiClient.updateUserVoicemail(
      _token,
      messageId,
      seen: seen,
      locale: locale.toString(),
      options: RequestOptions.withNoRetries(),
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
  Future<List<Voicemail>> getVoicemailList(Locale locale) async {
    final voicmailLis = await _webtritApiClient.getUserVoicemailList(
      _token,
      locale: locale.toString(),
      options: RequestOptions.withNoRetries(),
    );

    final voicemailFutures = voicmailLis.items.map((item) async {
      final details = await _webtritApiClient.getUserVoicemail(_token, item.id);
      print('details: $details');

      final path = await getOrSaveVoicemailAttachmentFile(item.id);
      print('converted to path: $path');
      return Voicemail(
        item.id,
        item.date,
        item.duration,
        details.sender,
        details.receiver,
        item.seen,
        item.size,
        item.type,
        [path],
      );
    }).toList();

    return Future.wait(voicemailFutures);
  }

  @override
  Future<String> getOrSaveVoicemailAttachmentFile(String messageId) async {
    final filename = 'voicemail_$messageId.wav';
    print('getOrSaveVoicemailAttachmentFile: $filename');
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$filename');

    print('file: ${file.path}');

    // // ✅ якщо файл уже є — просто повертаємо шлях
    // if (await file.exists()) {
    //   return file.path;
    // }

    // ⬇️ якщо немає — робимо запит і зберігаємо


    final rawBytes = await getVoicemailAttachment(messageId); // має повертати Uint8List
    print('rawBytes: $rawBytes');
    await file.writeAsBytes(rawBytes, flush: true); // 👈 flush for safety
    print('file: ${file.path}');

    return file.path;
  }
}
