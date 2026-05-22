/// Identifier types accepted on the OTP sign-in screen, mirroring the values
/// advertised by the backend adapter in `system-info`
/// (`adapter.custom.otp_login_identifiers`).
enum OtpSigninIdentifier {
  phoneNumber('phone_number'),
  email('email');

  const OtpSigninIdentifier(this.value);

  /// Wire value as returned by the backend.
  final String value;

  /// Maps backend wire values to known identifiers, dropping unrecognised ones.
  static List<OtpSigninIdentifier> fromValues(List<String> values) =>
      values.map(_fromValue).whereType<OtpSigninIdentifier>().toList(growable: false);

  static OtpSigninIdentifier? _fromValue(String value) {
    for (final identifier in OtpSigninIdentifier.values) {
      if (identifier.value == value) return identifier;
    }
    return null;
  }
}
