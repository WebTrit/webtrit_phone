import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/app/session/session.dart';

class MockSessionVerifier extends Mock implements SessionVerifier {}

void main() {
  late MockSessionVerifier verifier;
  late List<SessionVerificationResult> logouts;
  late SessionInvalidationHandler handler;

  setUp(() {
    verifier = MockSessionVerifier();
    logouts = [];
    handler = SessionInvalidationHandler(verifier, performLogout: logouts.add);
  });

  void stubVerify(SessionVerificationResult result) {
    when(() => verifier.verify()).thenAnswer((_) async => result);
  }

  group('SessionInvalidationHandler', () {
    test('logs out on a missed session', () async {
      stubVerify(const SessionMissed());

      await handler.onSessionMissedReported();

      expect(logouts.single, isA<SessionMissed>());
    });

    test('logs out on a required password change', () async {
      stubVerify(const SessionPasswordChangeRequired());

      await handler.onSessionMissedReported();

      expect(logouts.single, isA<SessionPasswordChangeRequired>());
    });

    test('does not duplicate a logout owned by the session guard', () async {
      stubVerify(const SessionLogoutDelegated());

      await handler.onSessionMissedReported();

      expect(logouts, isEmpty);
    });

    test('resolves a programming error without rethrowing', () async {
      when(() => verifier.verify()).thenAnswer((_) async => throw StateError('bug'));

      await handler.onSessionMissedReported();

      expect(logouts, isEmpty);
    });
  });
}
