import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/common/common.dart';

import 'session_guard.dart';

typedef SessionGuardCallback = FutureOr<void> Function(Exception e);

final _log = Logger('RouterLogoutSessionGuard');

/// A [SessionGuard] that triggers logout when the backend signals
/// an invalid session (e.g. `422` with `code=refresh_token_invalid`).
///
/// Features:
/// - Handles only the first unauthorized event; ignores subsequent ones.
/// - Optionally runs [onPreLogout] before [performLogout].
/// - Implements [Disposable] to stop handling after disposal.
///
/// Typical usage:
/// - Attach to repositories or API clients to enforce automatic logout
///   when the session becomes invalid.
class RouterLogoutSessionGuard implements SessionGuard, Disposable {
  /// Creates a new [RouterLogoutSessionGuard] instance.
  RouterLogoutSessionGuard({required this.performLogout, this.onPreLogout});

  /// Function that performs the actual logout (e.g. dispatching a logout event).
  /// Receives the unauthorized [Exception] so callers can tailor the logout
  /// (e.g. distinguish an expired session from a deleted account).
  final SessionGuardCallback performLogout;

  /// Optional hook executed before [performLogout].
  /// Useful for cleaning up resources or saving state. Receives the same
  /// unauthorized [Exception] passed to [performLogout].
  final SessionGuardCallback? onPreLogout;

  bool _handled = false;
  bool _disposed = false;

  @override
  void onUnauthorized(Exception e) {
    if (!_markHandled()) {
      _log.finest('Skip: unauthorized already handled');
      return;
    }

    Future.microtask(() async {
      if (_disposed) {
        _log.finest('Skip: already disposed');
        return;
      }

      _log.warning('Unauthorized access detected: ${e.toString()}');

      await _runHookSafe(e);
      await _runLogoutSafe(e);
    });
  }

  bool _markHandled() {
    if (_handled) return false;
    _handled = true;
    return true;
  }

  Future<void> _runHookSafe(Exception e) async {
    final hook = onPreLogout;
    if (hook == null) return;
    try {
      await hook(e);
    } catch (err, st) {
      _log.warning('onBeforeLogout failed', err, st);
    }
  }

  Future<void> _runLogoutSafe(Exception e) async {
    try {
      await performLogout(e);
    } catch (err, st) {
      _log.severe('logoutLocal failed', err, st);
    }
  }

  @override
  Future<void> dispose() async {
    _disposed = true;
  }
}
