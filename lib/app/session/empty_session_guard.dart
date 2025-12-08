import 'package:logging/logging.dart';

import 'session_guard.dart';

final _logger = Logger('EmptySessionGuard');

/// A no-op implementation of [SessionGuard].
///
/// [EmptySessionGuard] only logs unauthorized access events without
/// performing any session cleanup or logout logic.
///
/// This can be useful in scenarios such as:
/// - Testing or development environments where full session handling
///   is not required.
/// - Cases where the app should remain functional despite unauthorized
///   responses.
/// - Providing a default [SessionGuard] to avoid `null` checks.
/// ```
class EmptySessionGuard implements SessionGuard {
  /// Creates a new [EmptySessionGuard] instance.
  const EmptySessionGuard();

  /// Logs the unauthorized exception without triggering any
  /// additional actions such as logout or cleanup.
  ///
  /// [e] The exception that triggered the unauthorized state.
  @override
  void onUnauthorized(Exception e) {
    _logger.warning('Unauthorized access detected: ${e.toString()}');
  }
}
