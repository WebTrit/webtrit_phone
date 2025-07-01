import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

extension SecureStorageExtension on SecureStorage {
  Future<void> writeExternalPageToken(ExternalPageToken token) async {
    await writeExternalPageAccessToken(token.accessToken);
    await writeExternalPageRefreshToken(token.refreshToken);
    await writeExternalPageTokenExpires(token.expiration.toIso8601String());
  }

  ExternalPageToken? readExternalPageToken() {
    final accessToken = readExternalPageAccessToken();
    final refreshToken = readExternalPageRefreshToken();
    final expires = readExternalPageTokenExpires();

    if ([accessToken, refreshToken, expires].any((v) => v == null || v.isEmpty)) {
      return null;
    }

    final expiresAt = DateTime.tryParse(expires!);
    if (expiresAt == null) {
      return null;
    }

    return ExternalPageToken(accessToken!, refreshToken!, expiresAt);
  }
}
