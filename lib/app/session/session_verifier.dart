import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('SessionVerifier');

/// Outcome of probing the account session over the REST API after the
/// signaling layer reported the session as missing.
sealed class SessionVerdict {
  const SessionVerdict();
}

/// The REST API served the request with the current token, so the session is
/// alive and the signaling report must not force a logout.
class SessionAlive extends SessionVerdict {
  const SessionAlive();
}

/// The backend rejected the session, so the app should log out.
class SessionMissed extends SessionVerdict {
  const SessionMissed();
}

/// The self-care password expired or was changed, so the app should log out
/// with the dedicated message.
class SessionPasswordChangeRequired extends SessionVerdict {
  const SessionPasswordChangeRequired();
}

/// An auth error owned by the [SessionGuard] wired into the user datasource.
/// The guard dispatches its own logout, so the caller must not dispatch a
/// second, conflicting one.
class SessionVerdictDelegated extends SessionVerdict {
  const SessionVerdictDelegated();
}

/// The backend could not be reached or answered with a server-side failure.
/// There is no verdict about the session, so the caller must keep it.
class SessionUnverifiable extends SessionVerdict {
  const SessionUnverifiable();
}

/// Verifies over the REST API whether the account session is still valid.
///
/// A logout requires positive evidence: transport failures and 5xx responses
/// carry no verdict about the session and resolve to [SessionUnverifiable],
/// so a backend outage never logs the user out. If the session is really
/// gone, the signaling layer keeps reporting it and a later verification gets the
/// definitive answer once the backend recovers.
class SessionVerifier {
  SessionVerifier(this._userRepository);

  final UserRepository _userRepository;

  Future<SessionVerdict> verify() async {
    try {
      await _userRepository.getRemoteInfo();
      return const SessionAlive();
    } on PasswordChangeRequiredException {
      _logger.info('verify: password change required');
      return const SessionPasswordChangeRequired();
    } on UnauthorizedException {
      _logger.info('verify: unauthorized - verdict delegated to the session guard');
      return const SessionVerdictDelegated();
    } on UserNotFoundException {
      _logger.info('verify: user not found - verdict delegated to the session guard');
      return const SessionVerdictDelegated();
    } on SessionMissingException {
      _logger.info('verify: session missing - verdict delegated to the session guard');
      return const SessionVerdictDelegated();
    } on RequestFailure catch (e) {
      final statusCode = e.statusCode;
      if (statusCode != null && statusCode >= 400 && statusCode < 500) {
        _logger.warning('verify: session rejected with status $statusCode, code: ${e.error?.code}');
        return const SessionMissed();
      }
      _logger.warning('verify: backend failure with status $statusCode, code: ${e.error?.code} - no verdict');
      return const SessionUnverifiable();
    } catch (e, st) {
      _logger.warning('verify: transport failure - no verdict', e, st);
      return const SessionUnverifiable();
    }
  }
}
