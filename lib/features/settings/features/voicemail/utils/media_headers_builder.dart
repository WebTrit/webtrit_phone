import 'package:webtrit_phone/data/data.dart';

/// A utility class responsible for building HTTP headers
/// used in media-related requests (e.g., for [LockCachingAudioSource]).
///
/// These headers typically include an `Authorization` bearer token
/// retrieved from [SecureStorage], which is required when accessing
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
  MediaHeadersBuilder({
    required this.secureStorage,
  });

  final SecureStorage secureStorage;

  /// Returns a map of HTTP headers including the Bearer token.
  Map<String, String> build() {
    final token = secureStorage.readToken();
    return {'authorization': 'Bearer $token'};
  }
}
