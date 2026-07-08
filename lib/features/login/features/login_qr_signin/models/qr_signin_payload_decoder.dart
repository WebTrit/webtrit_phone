import 'qr_signin_parse_result.dart';

/// One payload format the QR sign-in understands.
///
/// Decoders are probed in order by `QrSigninPayloadParser`: the first one that
/// RECOGNIZES the payload wins and fully decides the outcome (including
/// failures such as a host mismatch). Returning null means "this is not my
/// format, let the next decoder try" - it must be reserved for payloads the
/// decoder cannot claim at all, never for recognized-but-invalid ones.
abstract interface class QrSigninPayloadDecoder {
  QrSigninParseResult? decode(String raw);
}
