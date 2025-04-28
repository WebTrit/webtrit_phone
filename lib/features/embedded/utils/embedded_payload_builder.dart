import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

/// Builds the WebView payload on demand
class EmbeddedPayloadBuilder {
  EmbeddedPayloadBuilder(this._secureStorage);

  final SecureStorage _secureStorage;

  /// Builds a payload Map based on requested fields
  Map<String, dynamic> build(List<EmbeddedPayloadData> fields) {
    final Map<String, dynamic> payload = {};

    for (final field in fields) {
      switch (field) {
        case EmbeddedPayloadData.userId:
          payload['userId'] = _secureStorage.readUserId();
          break;
        case EmbeddedPayloadData.coreToken:
          payload['coreToken'] = _secureStorage.readToken();
          break;
        case EmbeddedPayloadData.externalPageToken:
          final accessToken = _secureStorage.readExternalPageAccessToken() ?? '';
          final refreshToken = _secureStorage.readExternalPageRefreshToken() ?? '';
          final expiresAt = _secureStorage.readExternalPageTokenExpires() ?? '';

          if (accessToken.isNotEmpty && refreshToken.isNotEmpty && expiresAt.isNotEmpty) {
            payload['externalPageToken'] = {
              'accessToken': accessToken,
              'refreshToken': refreshToken,
              'expiresAt': expiresAt,
            };
          }
          break;
      }
    }

    return payload;
  }
}
