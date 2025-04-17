import 'dart:ui';

import 'package:webtrit_api/webtrit_api.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/mappers/mappers.dart';

abstract class VoicemailRepository {
  Future<List<UserVoicemailItem>> getVoicemailList(Locale locale);

  Future<UserVoicemail> getVoicemail(String messageId, Locale locale);

  Future<void> deleteVoicemail(String messageId, Locale locale);

  Future<void> updateVoicemailSeen(String messageId, bool seen, Locale locale);

  Future<String> getVoicemailAttachment(String messageId, {String? fileFormat, Locale? locale});
}

class VoicemailRepositoryImpl implements VoicemailRepository {
  VoicemailRepositoryImpl({
    required WebtritApiClient webtritApiClient,
    required String token,
  })  : _webtritApiClient = webtritApiClient,
        _token = token;

  final WebtritApiClient _webtritApiClient;
  final String _token;

  @override
  Future<List<UserVoicemailItem>> getVoicemailList(Locale locale) async {
    final response = await _webtritApiClient.getUserVoicemailList(
      _token,
      locale: locale.toString(),
      options: RequestOptions.withNoRetries(),
    );
    return response.items;
  }

  @override
  Future<UserVoicemail> getVoicemail(String messageId, Locale locale) {
    return _webtritApiClient.getUserVoicemail(
      _token,
      messageId,
      locale: locale.toString(),
      options: RequestOptions.withNoRetries(),
    );
  }

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
  Future<String> getVoicemailAttachment(
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
}
