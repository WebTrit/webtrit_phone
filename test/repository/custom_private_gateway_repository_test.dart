import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
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
      when(() => secureStorage.readToken()).thenReturn('user_token');
      await repo.dispose();

      verify(() => secureStorage.readToken()).called(1);
      verifyNever(() => secureStorage.deleteExternalPageTokenData());
    });

    test('clears external page token data when user token is missing', () async {
      when(() => secureStorage.readToken()).thenReturn(null);
      await repo.dispose();
      verify(() => secureStorage.readToken()).called(1);
      verify(() => secureStorage.deleteExternalPageTokenData()).called(1);
    });

    test('is idempotent: multiple dispose() calls do not throw and keep behavior', () async {
      when(() => secureStorage.readToken()).thenReturn(null);

      await repo.dispose();
      await repo.dispose();

      verify(() => secureStorage.readToken()).called(greaterThanOrEqualTo(2));
      verify(() => secureStorage.deleteExternalPageTokenData()).called(greaterThanOrEqualTo(1));
    });
  });
}
