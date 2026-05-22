import 'package:collection/collection.dart';

/// Identifier types accepted on the OTP sign-in screen, mirroring the values
/// advertised by the backend adapter in `system-info`
/// (`adapter.custom.otp_login_identifiers`).
enum OtpSigninIdentifier {
  phoneNumber('phone_number'),
  email('email');

  const OtpSigninIdentifier(this.value);

  /// Wire value as returned by the backend.
  final String value;

  /// Known identifier for a backend wire value, or `null` if unrecognised.
  static OtpSigninIdentifier? fromValue(String value) =>
      OtpSigninIdentifier.values.firstWhereOrNull((e) => e.value == value);

  /// Maps backend wire values to known identifiers, dropping unrecognised ones.
  static List<OtpSigninIdentifier> fromValues(List<String> values) =>
      values.map(fromValue).whereType<OtpSigninIdentifier>().toList(growable: false);
}
