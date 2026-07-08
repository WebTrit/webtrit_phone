import 'dart:convert';

import 'qr_signin_parse_result.dart';
import 'qr_signin_payload_decoder.dart';

/// Where the sign-in fields live in a JSON payload.
///
/// The default layout is the WebTrit-issued code shape; a dialect that only
/// renames fields or uses another marker is a different [JsonQrSigninStructure]
/// passed to the same decoder - no new decoder class needed. Payloads whose
/// shape differs beyond field names (nesting, different semantics) still get
/// their own [QrSigninPayloadDecoder].
class JsonQrSigninStructure {
  const JsonQrSigninStructure({
    this.markerKey = 't',
    this.markerValue = 'webtrit-signin',
    this.versionKey = 'v',
    this.supportedVersion = 1,
    this.userKey = 'user',
    this.passwordKey = 'password',
    this.hostKey = 'host',
  });

  /// Discriminator field and its expected value: bare JSON has no scheme, so
  /// only objects declaring the marker are treated as sign-in codes.
  final String markerKey;
  final String markerValue;

  /// Payload version field; an absent field means [supportedVersion].
  final String versionKey;
  final int supportedVersion;

  final String userKey;
  final String passwordKey;
  final String hostKey;
}

/// Decodes credential payloads carried as a JSON object:
///
/// ```json
/// {"t": "webtrit-signin", "v": 1, "user": "user123", "password": "p@ssword", "host": "EXAMPLE"}
/// ```
///
/// The field layout comes from [structure] (see [JsonQrSigninStructure]); any
/// JSON not declaring the structure's marker falls through to the next
/// decoder. `password` may be omitted or empty - the user reference is then
/// prefilled on the password tab. Unknown fields are ignored so the format can
/// grow without breaking older builds.
class JsonQrSigninPayloadDecoder implements QrSigninPayloadDecoder {
  JsonQrSigninPayloadDecoder({this.expectedHost, this.structure = const JsonQrSigninStructure()});

  final String? expectedHost;
  final JsonQrSigninStructure structure;

  /// Fields that would redirect the sign-in to another core; rejected
  /// regardless of the structure because a scanned code must not choose where
  /// credentials go.
  static const _coreOverrideKeys = {'core', 'tenant', 'core_url', 'tenant_id'};

  @override
  QrSigninParseResult? decode(String raw) {
    // Cheap pre-check: JSON objects of interest always start with a brace.
    if (!raw.startsWith('{')) return null;

    final Object? decoded;
    try {
      decoded = jsonDecode(raw);
    } on FormatException {
      return null; // Not JSON at all - not this decoder's payload.
    }
    if (decoded is! Map<String, Object?>) return null;
    if (decoded[structure.markerKey] != structure.markerValue) return null;

    final version = decoded[structure.versionKey] ?? structure.supportedVersion;
    if (version != structure.supportedVersion) {
      return const QrSigninParseFailure(QrSigninParseError.unsupportedVersion);
    }

    if (decoded.keys.any(_coreOverrideKeys.contains)) {
      return const QrSigninParseFailure(QrSigninParseError.coreOverrideNotAllowed);
    }

    final expectedHost = this.expectedHost;
    if (expectedHost != null) {
      final host = decoded[structure.hostKey];
      if (host is! String || host.toLowerCase() != expectedHost.toLowerCase()) {
        return const QrSigninParseFailure(QrSigninParseError.hostMismatch);
      }
    }

    final userRef = decoded[structure.userKey];
    if (userRef is! String || userRef.isEmpty) return const QrSigninParseFailure(QrSigninParseError.malformed);

    final password = decoded[structure.passwordKey];
    if (password != null && password is! String) return const QrSigninParseFailure(QrSigninParseError.malformed);
    if (password == null || (password as String).isEmpty) return QrSigninUserRefOnly(userRef: userRef);

    return QrSigninCredentials(userRef: userRef, password: password);
  }
}
