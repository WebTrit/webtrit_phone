import 'dart:async';

import 'package:clock/clock.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';

/// Supplies the ICE servers a new WebRTC peer connection should use.
///
/// Deployments may bundle their own STUN/TURN servers; those are served with
/// short-lived TURN credentials, so the configuration is fetched, cached, and
/// renewed inside the session rather than read once at startup.
abstract interface class IceServersRepository {
  /// ICE servers for a peer connection about to be created, in the
  /// `RTCIceServer` shape flutter_webrtc expects.
  ///
  /// Never throws and never returns an empty list: when the deployment offers
  /// no configuration, or it cannot be reached in time, the public STUN
  /// fallback is returned so call setup proceeds.
  Future<List<Map<String, dynamic>>> resolveIceServers();
}

final _logger = Logger('IceServersRepository');

/// How long call setup may wait for a first fetch before falling back.
///
/// Only ever paid once per session, and only by a call started before the
/// polling service's leading refresh has landed.
const kIceServersFirstFetchTimeout = Duration(seconds: 3);

class IceServersRepositoryImpl with IceServersApiMapper implements IceServersRepository, Refreshable, Disposable {
  IceServersRepositoryImpl({required WebtritApiClient webtritApiClient, required String token})
    : _webtritApiClient = webtritApiClient,
      _token = token;

  final WebtritApiClient _webtritApiClient;
  final String _token;

  IceServersConfig? _config;

  /// Deduplicates a fetch in flight, so a burst of calls (or a poll racing a
  /// call) issues one request.
  Future<IceServersConfig?>? _inFlight;

  /// Always polled: whether the deployment has a configuration to serve at all
  /// is decided by `CoreSupport.supportsBundledIceServers` before this
  /// repository is built, so every failure it meets here is treated as
  /// transient and retried for the rest of the session.
  @override
  bool get isActive => true;

  @override
  Future<List<Map<String, dynamic>>> resolveIceServers() async {
    final cached = _config;
    if (cached != null && !cached.isDueForRefresh(clock.now())) {
      return cached.servers;
    }

    // A cached-but-due configuration is still usable, so only a cold cache is
    // worth waiting for; otherwise the renewal runs in the background and this
    // call uses what is already there.
    if (cached != null) {
      unawaited(_fetch());
      return cached.servers;
    }

    // A fetch reports its own failures and answers null, so the only thing
    // left to guard here is a fetch too slow to hold up call setup.
    IceServersConfig? config;
    try {
      config = await _fetch().timeout(kIceServersFirstFetchTimeout);
    } on TimeoutException {
      _logger.warning('Ice servers configuration did not arrive within $kIceServersFirstFetchTimeout');
    }

    if (config != null && !config.isEmpty) {
      return config.servers;
    }

    return kFallbackRtcIceServers;
  }

  /// Polling hook: renews the configuration only when the cached one is due,
  /// so the common tick costs nothing.
  @override
  Future<void> refresh() async {
    final cached = _config;
    if (cached != null && !cached.isDueForRefresh(clock.now())) {
      _logger.finest('Cached ice servers configuration is still fresh, skipping refresh');
      return;
    }

    await _fetch();
  }

  Future<IceServersConfig?> _fetch() {
    return _inFlight ??= _performFetch().whenComplete(() => _inFlight = null);
  }

  Future<IceServersConfig?> _performFetch() async {
    try {
      final response = await _webtritApiClient.getUserIceServers(_token);
      final config = iceServersConfigFromApi(response);

      if (config.isEmpty) {
        // The endpoint exists but the deployment configured nothing; keep the
        // fallback rather than caching an empty list as a success.
        _logger.info('Core returned no ice servers, keeping the public STUN fallback');
        _config = null;
        return null;
      }

      _config = config;
      _logger.info('Loaded ${config.servers.length} ice server(s), expiring at ${config.expiresAt}');
      return config;
    } catch (e, s) {
      // Swallowed on purpose: a call resolves the fallback and the next poll
      // retries, so a failed fetch costs the user nothing beyond relay-less
      // ICE - no caller could do anything useful with a throw.
      _logger.warning('Failed to fetch ice servers configuration', e, s);
      CrashlyticsUtils.recordError(e, stack: s, reason: 'IceServersRepository: ice servers fetch failed');
      _config = null;
      return null;
    }
  }

  @override
  Future<void> dispose() async {
    _config = null;
    _inFlight = null;
  }
}

/// Used when the deployment bundles no ICE servers: always the public STUN
/// fallback, and nothing to refresh - it is not [Refreshable], so it cannot be
/// handed to the polling service at all.
class EmptyIceServersRepository implements IceServersRepository, Disposable {
  const EmptyIceServersRepository();

  @override
  Future<List<Map<String, dynamic>>> resolveIceServers() async => kFallbackRtcIceServers;

  @override
  Future<void> dispose() async {}
}
