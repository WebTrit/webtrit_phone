import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/app/session/session.dart';

class MockSessionVerifier extends Mock implements SessionVerifier {}

void main() {
  late MockSessionVerifier verifier;
  late List<SessionVerificationResult> logouts;
  late SessionSuspicionHandler handler;

  setUp(() {
    verifier = MockSessionVerifier();
    logouts = [];
    handler = SessionSuspicionHandler(verifier, performLogout: logouts.add);
  });

  void stubVerify(SessionVerificationResult result) {
    when(() => verifier.verify()).thenAnswer((_) async => result);
  }

  group('SessionSuspicionHandler', () {
    test('logs out on a confirmed missed session', () async {
      stubVerify(const SessionMissed());

      await handler.onSessionSuspected();

      expect(logouts.single, isA<SessionMissed>());
    });

    test('logs out on a required password change', () async {
      stubVerify(const SessionPasswordChangeRequired());

      await handler.onSessionSuspected();

      expect(logouts.single, isA<SessionPasswordChangeRequired>());
    });

    test('keeps the session when it is alive', () async {
      stubVerify(const SessionAlive());

      await handler.onSessionSuspected();

      expect(logouts, isEmpty);
    });

    test('keeps the session when the check is inconclusive', () async {
      stubVerify(const SessionUnverifiable());

      await handler.onSessionSuspected();

      expect(logouts, isEmpty);
    });

    test('does not duplicate a logout owned by the session guard', () async {
      stubVerify(const SessionLogoutDelegated());

      await handler.onSessionSuspected();

      expect(logouts, isEmpty);
    });

    test('resolves a programming error without rethrowing', () async {
      when(() => verifier.verify()).thenAnswer((_) async => throw StateError('bug'));

      await handler.onSessionSuspected();

      expect(logouts, isEmpty);
    });
  });
}
