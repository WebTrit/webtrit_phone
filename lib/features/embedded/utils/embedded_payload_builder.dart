import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';

import '../models/models.dart';

/// Builds the WebView payload on demand
/// Emits exception if the requested payload is not available
class EmbeddedPayloadBuilder {
  EmbeddedPayloadBuilder(this._secureStorage);

  final SecureStorage _secureStorage;

  static const String userIdKey = 'userId';
  static const String coreTokenKey = 'coreToken';
  static const String externalPageTokenKey = 'externalPageToken';

  /// Builds a payload Map based on requested fields
  Map<String, dynamic> build(List<EmbeddedPayloadData> fields) {
    final Map<String, dynamic> payload = {};

    for (final field in fields) {
      switch (field) {
        case EmbeddedPayloadData.userId:
          final userId = _secureStorage.readUserId();
          payload[userIdKey] = userId;
          break;

        case EmbeddedPayloadData.coreToken:
          final token = _secureStorage.readToken();
          payload[coreTokenKey] = token;
          break;

        case EmbeddedPayloadData.externalPageToken:
          payload[externalPageTokenKey] = _buildExternalPageToken();
          break;
      }
    }

    return payload;
  }

  Map<String, String> _buildExternalPageToken() {
    final token = _secureStorage.readExternalPageToken();

    if (token == null || !token.isValid) {
      throw ExternalPageTokenUnavailableException();
    }

    return {
      'accessToken': token.accessToken,
      'refreshToken': token.refreshToken,
      'expiresAt': token.expiration.toIso8601String(),
    };
  }
}
