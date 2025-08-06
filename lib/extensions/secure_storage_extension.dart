import 'package:logging/logging.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

final _logger = Logger('SecureStorageExtension');

extension SecureStorageExtension on SecureStorage {
  Future<void> writeExternalPageToken(ExternalPageToken token) async {
    await writeExternalPageAccessToken(token.accessToken);
    await writeExternalPageRefreshToken(token.refreshToken);
    await writeExternalPageTokenExpires(token.expiration.toIso8601String());
    await writeExternalPageAccessTokenSessionAssociated(readToken() ?? '');
  }

  ExternalPageToken? readExternalPageToken() {
    final accessToken = readExternalPageAccessToken();
    final refreshToken = readExternalPageRefreshToken();
    final expires = readExternalPageTokenExpires();
    final accessTokenSessionAssociated = readExternalPageAccessTokenSessionAssociated();
    final sessionToken = readToken();

    if ([accessToken, refreshToken, expires, accessTokenSessionAssociated, sessionToken]
        .any((v) => v == null || v.isEmpty)) {
      _logger.info('External page token is not set or incomplete.');
      return null;
    }

    final expiresAt = DateTime.tryParse(expires!);
    if (expiresAt == null) {
      _logger.warning('Invalid expiration date format: $expires');
      return null;
    }

    // If the access token was associated with a different session token,
    // it means the user has logged out and a new session has started.
    // In this case, the external page token is no longer valid and must not be reused.
    // This helps prevent leaking tokens between sessions and ensures security consistency.
    // TODO: Also add possibility clear cache on logout correctly.
    if (accessTokenSessionAssociated != sessionToken) {
      _logger.info('Session changed, external page token is not valid for current session.');
      return null;
    }

    return ExternalPageToken(accessToken!, refreshToken!, expiresAt);
  }
}
