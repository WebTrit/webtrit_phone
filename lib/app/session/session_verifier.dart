import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('SessionVerifier');

/// Outcome of probing the account session over the REST API after the
/// signaling layer reported the session as missing.
sealed class SessionVerificationResult {
  const SessionVerificationResult();
}

/// The REST API served the request with the current token, so the session is
/// alive and the signaling report must not force a logout.
class SessionAlive extends SessionVerificationResult {
  const SessionAlive();
}

/// The backend rejected the session, so the app should log out.
class SessionMissed extends SessionVerificationResult {
  const SessionMissed();
}

/// The self-care password expired or was changed, so the app should log out
/// with the dedicated message.
class SessionPasswordChangeRequired extends SessionVerificationResult {
  const SessionPasswordChangeRequired();
}

/// An auth error owned by the [SessionGuard] wired into the user datasource.
/// The guard dispatches its own logout, so the caller must not dispatch a
/// second, conflicting one.
class SessionLogoutDelegated extends SessionVerificationResult {
  const SessionLogoutDelegated();
}

/// The backend could not be reached or answered with a server-side failure.
/// The check says nothing about the session, so the caller must keep it.
class SessionUnverifiable extends SessionVerificationResult {
  const SessionUnverifiable();
}

/// Verifies over the REST API whether the account session is still valid.
///
/// A logout requires positive evidence: transport failures, 5xx responses
/// and 4xx responses produced by intermediaries (load balancers, proxies,
/// WAFs) say nothing about the session and resolve to
/// [SessionUnverifiable], so a backend outage never logs the user out. If
/// the session is really gone, the signaling layer keeps reporting it and a
/// later verification gets the definitive answer once the backend recovers.
class SessionVerifier {
  SessionVerifier(this._userRepository);

  final UserRepository _userRepository;

  Future<SessionVerificationResult> verify() async {
    try {
      await _userRepository.getRemoteInfo();
      return const SessionAlive();
    } on PasswordChangeRequiredException {
      _logger.info('verify: password change required');
      return const SessionPasswordChangeRequired();
    } on UnauthorizedException {
      _logger.info('verify: unauthorized - logout delegated to the session guard');
      return const SessionLogoutDelegated();
    } on UserNotFoundException {
      _logger.info('verify: user not found - logout delegated to the session guard');
      return const SessionLogoutDelegated();
    } on SessionMissingException {
      _logger.info('verify: session missing - logout delegated to the session guard');
      return const SessionLogoutDelegated();
    } on RequestFailure catch (e) {
      // A rejection is conclusive only when the backend itself produced it:
      // a non-transient client error carrying a backend error code.
      // Status-only responses come from intermediaries and say nothing about
      // the session.
      final isBackendRejection = e.isClientError && !e.isTransient && e.errorCode != null;
      if (isBackendRejection) {
        _logger.warning('verify: session rejected with status ${e.statusCode}, code: ${e.errorCode}');
        return const SessionMissed();
      }
      _logger.warning('verify: inconclusive status ${e.statusCode}, code: ${e.errorCode}');
      return const SessionUnverifiable();
    } catch (e, st) {
      _logger.warning('verify: transport failure - inconclusive', e, st);
      return const SessionUnverifiable();
    }
  }
}
