import 'package:webtrit_phone/repositories/repositories.dart';

/// A utility class responsible for building HTTP headers
/// used in media-related requests (e.g., for [LockCachingAudioSource]).
///
/// These headers typically include an `Authorization` bearer token
/// taken from the current session, which is required when accessing
/// protected media endpoints on the Core backend.
///
/// Example usage:
/// ```
/// final headers = mediaHeadersBuilder.build();
/// ```
///
/// Example endpoint requiring headers:
/// `https://core1.demo.webtrit.com/api/v1/user/voicemails/2184/attachment?file_format=mp3`
class MediaHeadersBuilder {
  MediaHeadersBuilder({required this.sessionRepository});

  final SessionRepository sessionRepository;

  /// Returns a map of HTTP headers including the Bearer token.
  Map<String, String> build() {
    final token = sessionRepository.getCurrent().token;
    return {'authorization': 'Bearer $token'};
  }
}
