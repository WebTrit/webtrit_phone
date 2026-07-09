import 'package:logging/logging.dart';

import 'package:webtrit_phone/utils/utils.dart';

import 'session_verifier.dart';

/// Function that performs the actual logout (e.g. dispatching a logout event).
/// Receives the backend-confirmed rejection - [SessionMissed] or
/// [SessionPasswordChangeRequired] - so callers can tailor the logout.
typedef ConfirmedRejectionCallback = void Function(SessionVerificationResult rejection);

final _logger = Logger('SessionSuspicionHandler');

/// Reacts to a signaling report that the account session is gone: verifies the
/// session over the REST API with [SessionVerifier] and calls [performLogout]
/// only on a backend-confirmed rejection. An inconclusive check (backend
/// outage) and a false report (session alive) keep the user logged in, and a
/// rejection already owned by the [SessionGuard] is left to it.
class SessionSuspicionHandler {
  SessionSuspicionHandler(this._verifier, {required this.performLogout});

  final SessionVerifier _verifier;

  final ConfirmedRejectionCallback performLogout;

  Future<void> onSessionSuspected() async {
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
        case SessionAlive():
          _logger.info('Session alive despite the signaling report - keeping the session');
        case SessionUnverifiable():
          _logger.info('Session state unverifiable (backend unavailable) - keeping the session');
      }
    } catch (e, st) {
      // verify() resolves every Exception itself, so what lands here is a
      // programming error from the verification or the logout dispatch.
      _logger.severe('Session suspicion handling failed', e, st);
      CrashlyticsUtils.recordError(e, stack: st, reason: 'SessionSuspicionHandler.onSessionSuspected');
    }
  }
}
