import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

void main() {
  QrSigninPayloadParser parser({List<QrSigninFormatConfig>? formats, String? expectedHost}) {
    return QrSigninPayloadParser.fromConfig(
      formats == null
          ? QrSigninConfig(enabled: true, expectedHost: expectedHost)
          : QrSigninConfig(enabled: true, formats: formats, expectedHost: expectedHost),
    );
  }

  group('QrSigninPayloadParser', () {
    group('decoder chain', () {
      test('rejects payloads no decoder recognizes', () {
        for (final raw in ['https://example.com', 'hello world', '', ':user:pass@EXAMPLE', '[1, 2]', '{"a": 1}']) {
          final result = parser().parse(raw);

          expect((result as QrSigninParseFailure).error, QrSigninParseError.unrecognized, reason: raw);
        }
      });

      test('only the configured formats are probed', () {
        final uriOnly = parser(formats: const [QrSigninFormatConfig(type: 'uri')]);
        final jsonPayload = jsonEncode({'t': 'webtrit-signin', 'user': 'user123', 'password': 'p@ss'});

        expect((uriOnly.parse(jsonPayload) as QrSigninParseFailure).error, QrSigninParseError.unrecognized);
        expect(uriOnly.parse('csc:user:pass@EXAMPLE'), isA<QrSigninCredentials>());
      });

      test('unknown format types are ignored', () {
        final result = parser(
          formats: const [
            QrSigninFormatConfig(type: 'xml'),
            QrSigninFormatConfig(type: 'uri'),
          ],
        ).parse('csc:user:pass@EXAMPLE');

        expect(result, isA<QrSigninCredentials>());
      });

      test('a uri format entry without schemes falls back to csc', () {
        final result = parser(formats: const [QrSigninFormatConfig(type: 'uri')]).parse('csc:user:pass@EXAMPLE');

        expect(result, isA<QrSigninCredentials>());
      });
    });

    group('uri format', () {
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
        final result = parser(
          formats: const [
            QrSigninFormatConfig(type: 'uri', schemes: ['csc', 'acme']),
          ],
        ).parse('acme:user:pass@EXAMPLE');

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

    group('json format', () {
      String payload(Map<String, Object?> fields) => jsonEncode({'t': 'webtrit-signin', ...fields});

      test('parses a marker-discriminated credentials object', () {
        final result = parser().parse(payload({'v': 1, 'user': 'user123', 'password': 'p@ssword'}));

        expect(result, isA<QrSigninCredentials>());
        final credentials = result as QrSigninCredentials;
        expect(credentials.userRef, 'user123');
        expect(credentials.password, 'p@ssword');
      });

      test('the version defaults to 1 when absent', () {
        expect(parser().parse(payload({'user': 'user123', 'password': 'p'})), isA<QrSigninCredentials>());
      });

      test('rejects an unsupported version', () {
        final result = parser().parse(payload({'v': 2, 'user': 'user123', 'password': 'p'}));

        expect((result as QrSigninParseFailure).error, QrSigninParseError.unsupportedVersion);
      });

      test('returns the user reference alone when the password is missing or empty', () {
        for (final fields in [
          {'user': 'user123'},
          {'user': 'user123', 'password': ''},
        ]) {
          final result = parser().parse(payload(fields));

          expect(result, isA<QrSigninUserRefOnly>(), reason: '$fields');
          expect((result as QrSigninUserRefOnly).userRef, 'user123');
        }
      });

      test('validates the host against the expected one', () {
        final pinned = parser(expectedHost: 'EXAMPLE');
        final matching = payload({'user': 'u', 'password': 'p', 'host': 'example'});
        final foreign = payload({'user': 'u', 'password': 'p', 'host': 'OTHER'});
        final absent = payload({'user': 'u', 'password': 'p'});

        expect(pinned.parse(matching), isA<QrSigninCredentials>());
        expect((pinned.parse(foreign) as QrSigninParseFailure).error, QrSigninParseError.hostMismatch);
        expect((pinned.parse(absent) as QrSigninParseFailure).error, QrSigninParseError.hostMismatch);
      });

      test('rejects core override fields', () {
        for (final key in ['core', 'tenant', 'core_url', 'tenant_id']) {
          final result = parser().parse(payload({'user': 'u', 'password': 'p', key: 'value'}));

          expect((result as QrSigninParseFailure).error, QrSigninParseError.coreOverrideNotAllowed, reason: key);
        }
      });

      test('ignores unknown fields', () {
        final result = parser().parse(payload({'user': 'u', 'password': 'p', 'brand': 'acme'}));

        expect(result, isA<QrSigninCredentials>());
      });

      test('rejects a missing or non-string user reference', () {
        for (final fields in [
          <String, Object?>{'password': 'p'},
          {'user': '', 'password': 'p'},
          {'user': 42, 'password': 'p'},
        ]) {
          final result = parser().parse(payload(fields));

          expect((result as QrSigninParseFailure).error, QrSigninParseError.malformed, reason: '$fields');
        }
      });

      test('JSON without the marker falls through as unrecognized', () {
        final result = parser().parse(jsonEncode({'user': 'u', 'password': 'p'}));

        expect((result as QrSigninParseFailure).error, QrSigninParseError.unrecognized);
      });

      test('a dialect with renamed fields is a structure parameter, not a new decoder', () {
        final dialect = QrSigninPayloadParser([
          JsonQrSigninPayloadDecoder(
            structure: const JsonQrSigninStructure(
              markerKey: 'kind',
              markerValue: 'acme-login',
              userKey: 'username',
              passwordKey: 'pwd',
            ),
          ),
        ]);

        final result = dialect.parse(jsonEncode({'kind': 'acme-login', 'username': 'user123', 'pwd': 'p@ss'}));

        expect(result, isA<QrSigninCredentials>());
        final credentials = result as QrSigninCredentials;
        expect(credentials.userRef, 'user123');
        expect(credentials.password, 'p@ss');
        // The default WebTrit shape is not this dialect's payload.
        final webtrit = dialect.parse(jsonEncode({'t': 'webtrit-signin', 'user': 'u', 'password': 'p'}));
        expect((webtrit as QrSigninParseFailure).error, QrSigninParseError.unrecognized);
      });
    });
  });
}
