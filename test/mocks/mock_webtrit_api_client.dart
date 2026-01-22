import 'package:mocktail/mocktail.dart';

import 'package:webtrit_api/webtrit_api.dart' as api;

class MockWebtritApiClient extends Mock implements api.WebtritApiClient {
  @override
  Future<api.UserVoicemailListResponse> getUserVoicemailList(String token, {String? locale, api.RequestOptions options = const api.RequestOptions()}) async {
    return api.UserVoicemailListResponse(
      hasNewMessages: false,
      items: [],
    );
  }

  @override
  Future<void> deleteUserVoicemail(String token, String messageId, {String? locale, api.RequestOptions options = const api.RequestOptions()}) async {}

  @override
  Future<void> updateUserVoicemail(String token, String messageId, {required bool seen, String? locale, api.RequestOptions options = const api.RequestOptions()}) async {}
}
