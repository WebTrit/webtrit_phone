/// The phrase is free text written by someone else's registrar, so these tests
/// pin down how loosely it may be matched: loose enough to survive the call-id
/// the platform appends and a change of casing, strict enough that a status
/// reused elsewhere cannot be mistaken for a refusal to register.
library;

import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/models/models.dart';

void main() {
  group('classifying a refused registration', () {
    test('a registrar with no node to serve the account is recognised', () {
      expect(
        RegistrationRejection.of(503, 'No target nodes for callid cb23792e-067b-1240-ab8d-02001700952a'),
        RegistrationRejection.platformUnavailable,
      );
    });

    test('the phrase is matched regardless of casing', () {
      expect(RegistrationRejection.of(503, 'NO TARGET NODES'), RegistrationRejection.platformUnavailable);
    });

    test('the same status with another phrase is not that refusal', () {
      expect(RegistrationRejection.of(503, 'busy line'), RegistrationRejection.unspecified);
    });

    test('the phrase alone, under another status, is not that refusal', () {
      expect(RegistrationRejection.of(500, 'No target nodes'), RegistrationRejection.unspecified);
    });

    test('an unrecognised refusal stays unspecified', () {
      expect(RegistrationRejection.of(500, 'Timeout from BE'), RegistrationRejection.unspecified);
    });

    test('a refusal that carries no detail stays unspecified', () {
      expect(RegistrationRejection.of(null, null), RegistrationRejection.unspecified);
      expect(RegistrationRejection.of(503, null), RegistrationRejection.unspecified);
      expect(RegistrationRejection.of(null, 'No target nodes'), RegistrationRejection.unspecified);
    });
  });

  group('what the call service reports', () {
    const failure = Registration(
      status: RegistrationStatus.registration_failed,
      code: 503,
      reason: 'No target nodes for callid abc',
    );

    test('a failed registration carries its recognised reason', () {
      const state = CallServiceState(registration: failure);

      expect(state.registrationRejection, RegistrationRejection.platformUnavailable);
    });

    test('a healthy registration reports no reason even with a stale code', () {
      const state = CallServiceState(
        registration: Registration(status: RegistrationStatus.registered, code: 503, reason: 'No target nodes'),
      );

      expect(state.registrationRejection, RegistrationRejection.unspecified);
    });

    test('no registration at all reports no reason', () {
      const state = CallServiceState();

      expect(state.registrationRejection, RegistrationRejection.unspecified);
    });
  });
}
