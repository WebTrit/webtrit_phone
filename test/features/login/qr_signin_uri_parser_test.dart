import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

void main() {
  QrSigninUriParser parser({List<String> schemes = const ['csc'], String? expectedHost}) {
    return QrSigninUriParser(QrSigninConfig(enabled: true, schemes: schemes, expectedHost: expectedHost));
  }

  group('QrSigninUriParser', () {
    test('parses the canonical provisioning URI', () {
      final result = parser().parse('csc:user123x777:p%40ss777@EXAMPLE');

      expect(result, isA<QrSigninCredentials>());
      final credentials = result as QrSigninCredentials;
      expect(credentials.userRef, 'user123x777');
      expect(credentials.password, 'p@ss777');
    });

    test('decodes percent-encoded reserved characters in both segments', () {
      final result = parser().parse('csc:user%3Aname%40host:p%40s%3As%3Fword@EXAMPLE');

      final credentials = result as QrSigninCredentials;
      expect(credentials.userRef, 'user:name@host');
      expect(credentials.password, 'p@s:s?word');
    });

    test('trims surrounding whitespace', () {
      final result = parser().parse('  csc:user:pass@EXAMPLE \n');

      expect(result, isA<QrSigninCredentials>());
    });

    test('matches the scheme case-insensitively', () {
      expect(parser().parse('CSC:user:pass@EXAMPLE'), isA<QrSigninCredentials>());
    });

    test('accepts any configured scheme', () {
      final result = parser(schemes: ['csc', 'acme']).parse('acme:user:pass@EXAMPLE');

      expect(result, isA<QrSigninCredentials>());
    });

    test('returns the user reference alone when the password is empty', () {
      final result = parser().parse('csc:user:@EXAMPLE');

      expect(result, isA<QrSigninUserRefOnly>());
      expect((result as QrSigninUserRefOnly).userRef, 'user');
    });

    test('returns the user reference alone when the password is omitted', () {
      final result = parser().parse('csc:user@EXAMPLE');

      expect(result, isA<QrSigninUserRefOnly>());
      expect((result as QrSigninUserRefOnly).userRef, 'user');
    });

    test('accepts a matching expected host regardless of case', () {
      final result = parser(expectedHost: 'EXAMPLE').parse('csc:user:pass@example');

      expect(result, isA<QrSigninCredentials>());
    });

    test('accepts the test-version host marker', () {
      final result = parser(expectedHost: 'EXAMPLE').parse('csc:user:pass@EXAMPLE*');

      expect(result, isA<QrSigninCredentials>());
    });

    test('rejects a foreign host when an expected host is configured', () {
      final result = parser(expectedHost: 'EXAMPLE').parse('csc:user:pass@OTHER');

      expect((result as QrSigninParseFailure).error, QrSigninParseError.hostMismatch);
    });

    test('accepts any host when no expected host is configured', () {
      expect(parser().parse('csc:user:pass@ANY-HOST'), isA<QrSigninCredentials>());
    });

    test('ignores unknown query parameters', () {
      final result = parser().parse('csc:user:pass@EXAMPLE?brand=acme&note=x%20y');

      expect(result, isA<QrSigninCredentials>());
    });

    test('accepts the explicit password method parameter', () {
      expect(parser().parse('csc:user:pass@EXAMPLE?m=password'), isA<QrSigninCredentials>());
    });

    test('rejects an unsupported method parameter', () {
      final result = parser().parse('csc:user:pass@EXAMPLE?m=autoprovision');

      expect((result as QrSigninParseFailure).error, QrSigninParseError.unsupportedMethod);
    });

    test('rejects core override parameters', () {
      for (final key in ['core', 'tenant', 'core_url', 'tenant_id']) {
        final result = parser().parse('csc:user:pass@EXAMPLE?$key=value');

        expect((result as QrSigninParseFailure).error, QrSigninParseError.coreOverrideNotAllowed, reason: key);
      }
    });

    test('rejects foreign schemes and non-URI payloads', () {
      for (final raw in ['https://example.com', 'hello world', '', ':user:pass@EXAMPLE']) {
        final result = parser().parse(raw);

        expect((result as QrSigninParseFailure).error, QrSigninParseError.unsupportedScheme, reason: raw);
      }
    });

    test('rejects malformed bodies', () {
      for (final raw in ['csc:userpassEXAMPLE', 'csc:user:pass@', 'csc:@EXAMPLE', 'csc::pass@EXAMPLE']) {
        final result = parser().parse(raw);

        expect((result as QrSigninParseFailure).error, QrSigninParseError.malformed, reason: raw);
      }
    });

    test('rejects broken percent-encoding', () {
      final result = parser().parse('csc:user%G1:pass@EXAMPLE');

      expect((result as QrSigninParseFailure).error, QrSigninParseError.malformed);
    });

    test('rejects broken percent-encoding in the query tail', () {
      final result = parser().parse('csc:user:pass@EXAMPLE?x=%zz');

      expect((result as QrSigninParseFailure).error, QrSigninParseError.malformed);
    });
  });
}
