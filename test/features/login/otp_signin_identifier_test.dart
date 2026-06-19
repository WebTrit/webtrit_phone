import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pub_semver/pub_semver.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/features/login/login.dart';
import 'package:webtrit_phone/models/models.dart';

LoginState _stateWithCustom(Map<String, dynamic>? custom) {
  return LoginState(
    systemInfo: WebtritSystemInfo(
      core: CoreInfo(version: Version(0, 15, 3)),
      postgres: PostgresInfo(),
      adapter: AdapterInfo(custom: custom),
    ),
  );
}

void main() {
  group('OtpSigninIdentifier.fromValues', () {
    test('maps known wire values preserving order', () {
      expect(OtpSigninIdentifier.fromValues(['email', 'phone_number']), [
        OtpSigninIdentifier.email,
        OtpSigninIdentifier.phoneNumber,
      ]);
    });

    test('drops unrecognised values', () {
      expect(OtpSigninIdentifier.fromValues(['phone_number', 'fax', 'email']), [
        OtpSigninIdentifier.phoneNumber,
        OtpSigninIdentifier.email,
      ]);
    });

    test('returns empty list for empty input', () {
      expect(OtpSigninIdentifier.fromValues(const []), isEmpty);
    });
  });

  group('AdapterInfo.otpLoginIdentifiers', () {
    test('reads string values from custom', () {
      final adapter = AdapterInfo(
        custom: const {
          kOtpLoginIdentifiersCustomKey: ['phone_number'],
        },
      );
      expect(adapter.otpLoginIdentifiers, ['phone_number']);
    });

    test('returns empty list when key is absent', () {
      expect(AdapterInfo(custom: const {}).otpLoginIdentifiers, isEmpty);
      expect(AdapterInfo().otpLoginIdentifiers, isEmpty);
    });

    test('returns empty list when value is not a list', () {
      final adapter = AdapterInfo(custom: const {kOtpLoginIdentifiersCustomKey: 'phone_number'});
      expect(adapter.otpLoginIdentifiers, isEmpty);
    });
  });

  group('LoginState.otpSigninIdentifiers', () {
    test('falls back to all identifiers when system info is missing', () {
      expect(const LoginState().otpSigninIdentifiers, OtpSigninIdentifier.values);
    });

    test('falls back to all identifiers when backend does not advertise the field', () {
      expect(_stateWithCustom(const {}).otpSigninIdentifiers, OtpSigninIdentifier.values);
    });

    test('returns only phone when backend advertises phone alone', () {
      final state = _stateWithCustom(const {
        kOtpLoginIdentifiersCustomKey: ['phone_number'],
      });
      expect(state.otpSigninIdentifiers, [OtpSigninIdentifier.phoneNumber]);
    });

    test('returns only email when backend advertises email alone', () {
      final state = _stateWithCustom(const {
        kOtpLoginIdentifiersCustomKey: ['email'],
      });
      expect(state.otpSigninIdentifiers, [OtpSigninIdentifier.email]);
    });
  });

  group('OtpSigninIdentifiersInput.userRefKeyboardType', () {
    test('allows letters for phone-only identifiers (alphanumeric accounts)', () {
      expect([OtpSigninIdentifier.phoneNumber].userRefKeyboardType, TextInputType.text);
    });

    test('uses the email keyboard when email is advertised', () {
      expect([OtpSigninIdentifier.email].userRefKeyboardType, TextInputType.emailAddress);
      expect(
        [OtpSigninIdentifier.phoneNumber, OtpSigninIdentifier.email].userRefKeyboardType,
        TextInputType.emailAddress,
      );
    });

    test('falls back to a text keyboard when nothing is advertised', () {
      expect(<OtpSigninIdentifier>[].userRefKeyboardType, TextInputType.text);
    });
  });
}
