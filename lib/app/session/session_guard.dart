/// A contract for guarding the current user session from unauthorized access.
///
/// Implementations of [SessionGuard] define how to react when an
/// unauthorized condition occurs (e.g. expired or invalid token).
///
/// Typical usage is to intercept API calls or repository actions
/// and trigger a logout or session cleanup when an [UnauthorizedException]
/// is received from the server.
abstract class SessionGuard {
  /// Called when an unauthorized exception is detected.
  ///
  /// Implementations should handle cleanup or logout logic here,
  /// ensuring the session is properly terminated or refreshed.
  ///
  /// [e] The exception that triggered the unauthorized state.
  void onUnauthorized(Exception e);
}
