import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import 'package:webtrit_api/webtrit_api.dart' hide Balance, Numbers, UserInfo;

import 'package:webtrit_phone/app/session/session.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class MockUserRepository extends Mock implements UserRepository {}

final _url = Uri.parse('https://core.example.com/api/v1/user');

final _testUser = UserInfo(
  numbers: Numbers(main: '1000', additional: []),
  balance: Balance(amount: 0, currency: 'USD'),
);

void main() {
  late MockUserRepository userRepository;
  late SessionVerifier verifier;

  setUp(() {
    userRepository = MockUserRepository();
    verifier = SessionVerifier(userRepository);
  });

  void stubVerifyError(Object error) {
    when(() => userRepository.getRemoteInfo()).thenAnswer((_) async => throw error);
  }

  group('SessionVerifier', () {
    test('resolves alive when the request succeeds', () async {
      when(() => userRepository.getRemoteInfo()).thenAnswer((_) async => _testUser);

      expect(await verifier.verify(), isA<SessionAlive>());
    });

    test('resolves password change required', () async {
      stubVerifyError(PasswordChangeRequiredException(url: _url, requestId: 'r1', statusCode: 403));

      expect(await verifier.verify(), isA<SessionPasswordChangeRequired>());
    });

    test('delegates the logout on unauthorized', () async {
      stubVerifyError(UnauthorizedException(url: _url, requestId: 'r1', statusCode: 401));

      expect(await verifier.verify(), isA<SessionLogoutDelegated>());
    });

    test('delegates the logout on user not found', () async {
      stubVerifyError(UserNotFoundException(url: _url, requestId: 'r1', statusCode: 404));

      expect(await verifier.verify(), isA<SessionLogoutDelegated>());
    });

    test('delegates the logout on session missing', () async {
      stubVerifyError(SessionMissingException(url: _url, requestId: 'r1', statusCode: 404));

      expect(await verifier.verify(), isA<SessionLogoutDelegated>());
    });

    test('resolves missed on an unmapped 4xx response with a backend error code', () async {
      stubVerifyError(
        RequestFailure(
          url: _url,
          requestId: 'r1',
          statusCode: 422,
          error: const ErrorResponse(code: 'some_code'),
        ),
      );

      expect(await verifier.verify(), isA<SessionMissed>());
    });

    test('resolves unverifiable on a rate-limited 4xx even with a backend error code', () async {
      stubVerifyError(
        RequestFailure(
          url: _url,
          requestId: 'r1',
          statusCode: 429,
          error: const ErrorResponse(code: 'rate_limited'),
        ),
      );

      expect(await verifier.verify(), isA<SessionUnverifiable>());
    });

    test('resolves unverifiable on a request-timeout 4xx', () async {
      stubVerifyError(RequestFailure(url: _url, requestId: 'r1', statusCode: 408));

      expect(await verifier.verify(), isA<SessionUnverifiable>());
    });

    test('resolves unverifiable on a too-early 4xx', () async {
      stubVerifyError(RequestFailure(url: _url, requestId: 'r1', statusCode: 425));

      expect(await verifier.verify(), isA<SessionUnverifiable>());
    });

    test('resolves unverifiable on a 4xx without a backend error code', () async {
      stubVerifyError(RequestFailure(url: _url, requestId: 'r1', statusCode: 403));

      expect(await verifier.verify(), isA<SessionUnverifiable>());
    });

    test('resolves unverifiable on a 5xx response', () async {
      stubVerifyError(
        RequestFailure(
          url: _url,
          requestId: 'r1',
          statusCode: 500,
          error: const ErrorResponse(code: 'external_api_issue'),
        ),
      );

      expect(await verifier.verify(), isA<SessionUnverifiable>());
    });

    test('resolves unverifiable on a response without a status code', () async {
      stubVerifyError(RequestFailure(url: _url, requestId: 'r1', statusCode: null));

      expect(await verifier.verify(), isA<SessionUnverifiable>());
    });

    test('resolves unverifiable on a socket failure', () async {
      stubVerifyError(const SocketException('connection refused'));

      expect(await verifier.verify(), isA<SessionUnverifiable>());
    });

    test('resolves unverifiable on a timeout', () async {
      stubVerifyError(TimeoutException('request timed out'));

      expect(await verifier.verify(), isA<SessionUnverifiable>());
    });

    test('propagates a programming error instead of resolving it', () async {
      stubVerifyError(StateError('bug'));

      expect(verifier.verify(), throwsStateError);
    });
  });
}
