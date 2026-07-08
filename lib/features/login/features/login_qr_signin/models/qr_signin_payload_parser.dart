import 'package:webtrit_phone/models/models.dart';

import 'json_qr_signin_payload_decoder.dart';
import 'qr_signin_parse_result.dart';
import 'qr_signin_payload_decoder.dart';
import 'uri_qr_signin_payload_decoder.dart';

/// Interprets scanned QR payloads by probing the configured
/// [QrSigninPayloadDecoder]s in order: the first decoder that recognizes the
/// payload fully decides the outcome; when none does, the payload is not a
/// sign-in code.
///
/// Supporting a new payload STRUCTURE is one new decoder plus its name in
/// [QrSigninConfig.formats]; existing decoders and callers stay untouched.
class QrSigninPayloadParser {
  QrSigninPayloadParser(List<QrSigninPayloadDecoder> decoders) : _decoders = List.unmodifiable(decoders);

  /// Builds the decoder chain from the app config, preserving the
  /// [QrSigninConfig.formats] order. Unknown format types are ignored.
  factory QrSigninPayloadParser.fromConfig(QrSigninConfig config) {
    return QrSigninPayloadParser([
      for (final format in config.formats)
        ?switch (format.type) {
          uriFormat => UriQrSigninPayloadDecoder(
            schemes: format.schemes ?? const [defaultUriScheme],
            expectedHost: config.expectedHost,
          ),
          jsonFormat => JsonQrSigninPayloadDecoder(expectedHost: config.expectedHost),
          _ => null,
        },
    ]);
  }

  /// The `scheme:user:password@host` provisioning URI format.
  static const uriFormat = 'uri';

  /// The marker-discriminated JSON object format.
  static const jsonFormat = 'json';

  /// Scheme assumed for a `uri` format entry that does not list its own.
  static const defaultUriScheme = 'csc';

  final List<QrSigninPayloadDecoder> _decoders;

  QrSigninParseResult parse(String rawValue) {
    final raw = rawValue.trim();
    if (raw.isNotEmpty) {
      for (final decoder in _decoders) {
        final result = decoder.decode(raw);
        if (result != null) return result;
      }
    }
    return const QrSigninParseFailure(QrSigninParseError.unrecognized);
  }
}
