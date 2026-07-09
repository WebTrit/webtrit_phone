import 'package:logging/logging.dart';

import 'package:webtrit_phone/utils/utils.dart';

import 'session_verifier.dart';

/// Function that performs the actual logout (e.g. dispatching a logout event).
/// Receives the resolution - [SessionMissed] or [SessionPasswordChangeRequired] -
/// so callers can tailor the logout.
typedef SessionInvalidationCallback = void Function(SessionVerificationResult resolution);

final _logger = Logger('SessionInvalidationHandler');

/// Reacts to a signaling report that the account session is gone: resolves
/// the reason over the REST API with [SessionVerifier] and calls
/// [performLogout] with it. The only resolution that does not dispatch a
/// logout is one already owned by the [SessionGuard].
class SessionInvalidationHandler {
  SessionInvalidationHandler(this._verifier, {required this.performLogout});

  final SessionVerifier _verifier;

  final SessionInvalidationCallback performLogout;

  Future<void> onSessionMissedReported() async {
    try {
      final result = await _verifier.verify();
      switch (result) {
        case SessionMissed():
        case SessionPasswordChangeRequired():
          performLogout(result);
        case SessionLogoutDelegated():
          // The session guard wired into the user datasource dispatches its
          // own, more specific logout - avoid a second, conflicting one.
          _logger.info('Logout delegated to the session guard');
      }
    } catch (e, st) {
      // verify() resolves every Exception itself, so what lands here is a
      // programming error from the resolution or the logout dispatch.
      _logger.severe('Session invalidation handling failed', e, st);
      CrashlyticsUtils.recordError(e, stack: st, reason: 'SessionInvalidationHandler.onSessionMissedReported');
    }
  }
}
