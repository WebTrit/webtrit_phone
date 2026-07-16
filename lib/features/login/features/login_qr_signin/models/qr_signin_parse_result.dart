/// Outcome of parsing a scanned QR payload.
sealed class QrSigninParseResult {
  const QrSigninParseResult();
}

/// Full credentials: the code carries both the user reference and the password.
class QrSigninCredentials extends QrSigninParseResult {
  const QrSigninCredentials({required this.userRef, required this.password});

  final String userRef;
  final String password;
}

/// The code carries only the user reference (password omitted or empty);
/// the user finishes signing in on the password tab.
class QrSigninUserRefOnly extends QrSigninParseResult {
  const QrSigninUserRefOnly({required this.userRef});

  final String userRef;
}

/// The payload is not a sign-in code this build accepts.
class QrSigninParseFailure extends QrSigninParseResult {
  const QrSigninParseFailure(this.error);

  final QrSigninParseError error;
}

enum QrSigninParseError {
  /// No configured decoder recognized the payload as a sign-in code.
  unrecognized,

  /// The code was issued for a different host (cloud id).
  hostMismatch,

  /// The code selects a sign-in method this build does not support.
  unsupportedMethod,

  /// The code tries to redirect the sign-in to another core.
  coreOverrideNotAllowed,

  /// The code declares a payload version this build does not understand.
  unsupportedVersion,

  /// The payload was recognized but its content is broken.
  malformed,
}
