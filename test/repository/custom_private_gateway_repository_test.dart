import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/session/session.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../mocks/mocks.dart';

void main() {
  late MockWebtritApiClient apiClient;
  late MockSecureStorage secureStorage;
  late CustomPrivateGatewayRepository repo;

  setUp(() {
    apiClient = MockWebtritApiClient();
    secureStorage = MockSecureStorage();

    repo = CustomPrivateGatewayRepository(apiClient, secureStorage, 'user_token', const EmptySessionGuard());
  });

  group('CustomPrivateGatewayRepository.dispose', () {
    test('does NOT clear external page token data when user token exists', () async {
      await secureStorage.writeToken('user_token');
      await secureStorage.writeExternalPageTokenData('access', 'refresh', 'expires', 'assoc');

      await repo.dispose();

      expect(secureStorage.readExternalPageAccessToken(), 'access');
      expect(secureStorage.readExternalPageRefreshToken(), 'refresh');
    });

    test('clears external page token data when user token is missing', () async {
      await secureStorage.deleteToken();
      await secureStorage.writeExternalPageTokenData('access', 'refresh', 'expires', 'assoc');

      await repo.dispose();

      expect(secureStorage.readExternalPageAccessToken(), isNull);
      expect(secureStorage.readExternalPageRefreshToken(), isNull);
      expect(secureStorage.readExternalPageAccessTokenSessionAssociated(), isNull);
    });

    test('is idempotent: multiple dispose() calls do not throw and keep behavior', () async {
      await secureStorage.deleteToken();
      await secureStorage.writeExternalPageTokenData('access', 'refresh', 'expires', 'assoc');

      await repo.dispose();
      await repo.dispose();

      expect(secureStorage.readExternalPageAccessToken(), isNull);
    });
  });
}
