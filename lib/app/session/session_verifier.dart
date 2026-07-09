import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('SessionVerifier');

/// Resolution of a session invalidation reported by the signaling layer.
sealed class SessionVerificationResult {
  const SessionVerificationResult();
}

/// The session is gone with no more specific account cause detected, so the
/// app should log out with the generic message.
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

/// Resolves the reason for a session invalidation reported by the signaling
/// layer.
///
/// The signaling report is trusted as final: the invalidation always ends in
/// a logout, and the REST probe only refines the reason - the dedicated
/// password-change message, a rejection already owned by the [SessionGuard],
/// or the generic missed session.
///
/// Extension point: this is where the REST answer could gate the logout
/// itself - keep the session when the backend is unreachable and only log out
/// on a backend-confirmed rejection - so a backend outage never signs the user
/// out. Deferred until spurious-logout reports justify the behavior change.
class SessionVerifier {
  SessionVerifier(this._userRepository);

  final UserRepository _userRepository;

  Future<SessionVerificationResult> verify() async {
    try {
      await _userRepository.getRemoteInfo();
      return const SessionMissed();
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
      _logger.warning('verify: account error code: ${e.errorCode}');
      return const SessionMissed();
    } on Exception catch (e, st) {
      _logger.warning('verify: request failed', e, st);
      return const SessionMissed();
    }
  }
}
