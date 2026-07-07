import 'dart:convert';

import 'qr_signin_parse_result.dart';
import 'qr_signin_payload_decoder.dart';

/// Decodes credential payloads carried as a JSON object:
///
/// ```json
/// {"t": "webtrit-signin", "v": 1, "user": "user123", "password": "p@ssword", "host": "EXAMPLE"}
/// ```
///
/// Bare JSON has no scheme to claim it, so the marker field `t` is the
/// discriminator: only objects declaring `"t": "webtrit-signin"` are treated
/// as sign-in codes; any other text or JSON falls through to the next decoder.
/// `v` is the payload version (absent means 1). `password` may be omitted or
/// empty - the user reference is then prefilled on the password tab. Unknown
/// fields are ignored so the format can grow without breaking older builds.
class JsonQrSigninPayloadDecoder implements QrSigninPayloadDecoder {
  JsonQrSigninPayloadDecoder({this.expectedHost});

  final String? expectedHost;

  static const _markerKey = 't';
  static const _markerValue = 'webtrit-signin';
  static const _versionKey = 'v';
  static const _supportedVersion = 1;
  static const _userKey = 'user';
  static const _passwordKey = 'password';
  static const _hostKey = 'host';

  /// Fields that would redirect the sign-in to another core; rejected because
  /// a scanned code must not choose where credentials go.
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
    if (decoded[_markerKey] != _markerValue) return null;

    final version = decoded[_versionKey] ?? _supportedVersion;
    if (version != _supportedVersion) return const QrSigninParseFailure(QrSigninParseError.unsupportedVersion);

    if (decoded.keys.any(_coreOverrideKeys.contains)) {
      return const QrSigninParseFailure(QrSigninParseError.coreOverrideNotAllowed);
    }

    final expectedHost = this.expectedHost;
    if (expectedHost != null) {
      final host = decoded[_hostKey];
      if (host is! String || host.toLowerCase() != expectedHost.toLowerCase()) {
        return const QrSigninParseFailure(QrSigninParseError.hostMismatch);
      }
    }

    final userRef = decoded[_userKey];
    if (userRef is! String || userRef.isEmpty) return const QrSigninParseFailure(QrSigninParseError.malformed);

    final password = decoded[_passwordKey];
    if (password != null && password is! String) return const QrSigninParseFailure(QrSigninParseError.malformed);
    if (password == null || (password as String).isEmpty) return QrSigninUserRefOnly(userRef: userRef);

    return QrSigninCredentials(userRef: userRef, password: password);
  }
}
