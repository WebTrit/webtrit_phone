import 'qr_signin_parse_result.dart';
import 'qr_signin_payload_decoder.dart';

/// Decodes provisioning sign-in URIs of the form
/// `scheme:userRef:password@host[?query]` (for example
/// `csc:user123:p%40ssword@EXAMPLE`).
///
/// The `userRef` and `password` segments are percent-encoded, so a literal
/// `:` or `@` can only appear between them; this makes splitting at the last
/// `@` (host) and the first `:` (credentials) unambiguous. A `?query` tail is
/// cut off before the split; unknown query parameters are ignored so that
/// generator-side extras do not break scanning. The reserved parameter `m`
/// selects the sign-in method; only the default `password` method is supported.
///
/// [Uri.parse] is not applicable here: without a `//` the URI has no authority
/// component, so the userinfo/host parts would not be recognized.
class UriQrSigninPayloadDecoder implements QrSigninPayloadDecoder {
  UriQrSigninPayloadDecoder({required List<String> schemes, this.expectedHost})
    : _schemes = schemes.map((s) => s.toLowerCase()).toList();

  final List<String> _schemes;
  final String? expectedHost;

  /// Query parameter selecting the sign-in method. Absent means password.
  static const _methodKey = 'm';
  static const _passwordMethod = 'password';

  /// Query parameters that would redirect the sign-in to another core;
  /// rejected because a scanned code must not choose where credentials go.
  static const _coreOverrideKeys = {'core', 'tenant', 'core_url', 'tenant_id'};

  /// Marker suffix of a test (non-approved) host in the generator portal.
  static const _testHostSuffix = '*';

  @override
  QrSigninParseResult? decode(String raw) {
    final schemeEnd = raw.indexOf(':');
    if (schemeEnd <= 0) return null;
    final scheme = raw.substring(0, schemeEnd).toLowerCase();
    // An unknown scheme is not this decoder's payload at all.
    if (!_schemes.contains(scheme)) return null;

    var body = raw.substring(schemeEnd + 1);
    Map<String, String> query = const {};
    final queryStart = body.indexOf('?');
    if (queryStart != -1) {
      try {
        query = Uri.splitQueryString(body.substring(queryStart + 1));
        // Broken percent-encoding surfaces as ArgumentError, not FormatException.
      } on ArgumentError {
        return const QrSigninParseFailure(QrSigninParseError.malformed);
      } on FormatException {
        return const QrSigninParseFailure(QrSigninParseError.malformed);
      }
      body = body.substring(0, queryStart);
    }

    final method = query[_methodKey] ?? _passwordMethod;
    if (method != _passwordMethod) return const QrSigninParseFailure(QrSigninParseError.unsupportedMethod);
    if (query.keys.any(_coreOverrideKeys.contains)) {
      return const QrSigninParseFailure(QrSigninParseError.coreOverrideNotAllowed);
    }

    final hostStart = body.lastIndexOf('@');
    if (hostStart == -1) return const QrSigninParseFailure(QrSigninParseError.malformed);
    final userinfo = body.substring(0, hostStart);
    var host = body.substring(hostStart + 1);
    if (host.endsWith(_testHostSuffix)) host = host.substring(0, host.length - 1);
    if (host.isEmpty) return const QrSigninParseFailure(QrSigninParseError.malformed);

    final expectedHost = this.expectedHost;
    if (expectedHost != null && host.toLowerCase() != expectedHost.toLowerCase()) {
      return const QrSigninParseFailure(QrSigninParseError.hostMismatch);
    }

    if (userinfo.isEmpty) return const QrSigninParseFailure(QrSigninParseError.malformed);
    final passwordStart = userinfo.indexOf(':');
    final encodedUserRef = passwordStart == -1 ? userinfo : userinfo.substring(0, passwordStart);
    final encodedPassword = passwordStart == -1 ? '' : userinfo.substring(passwordStart + 1);

    final String userRef;
    final String password;
    try {
      userRef = Uri.decodeComponent(encodedUserRef);
      password = Uri.decodeComponent(encodedPassword);
    } on ArgumentError {
      return const QrSigninParseFailure(QrSigninParseError.malformed);
    }
    if (userRef.isEmpty) return const QrSigninParseFailure(QrSigninParseError.malformed);

    if (password.isEmpty) return QrSigninUserRefOnly(userRef: userRef);
    return QrSigninCredentials(userRef: userRef, password: password);
  }
}
