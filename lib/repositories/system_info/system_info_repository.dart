import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/system_info/system_info_remote_datasource.dart';

import 'system_info_local_datasource.dart';

enum FetchPolicy {
  /// Returns cached data if available; falls back to a network request.
  cacheFirst,

  /// Always fetches from the network, updating local cache and listeners.
  /// Does not read from the cache.
  networkOnly,

  /// Returns data only from the local cache. No network requests are made.
  /// Returns `null` if no cached value exists.
  cacheOnly,
}

abstract interface class SystemInfoRepository implements Refreshable, Disposable {
  /// A broadcast stream that emits updated [WebtritSystemInfo] whenever
  /// a successful network fetch occurs or the local cache is updated.
  Stream<WebtritSystemInfo> get infoStream;

  /// The [fetchPolicy] determines whether to use cached data, fetch from the network,
  /// or only use the cache. Typically used during login or initial setup flows.
  Future<WebtritSystemInfo?> getSystemInfo({FetchPolicy fetchPolicy = FetchPolicy.cacheFirst});

  /// Preloads the repository with fresh data obtained from an external source
  /// (e.g., during the login flow).
  ///
  /// This updates the local cache and emits the new value to [infoStream],
  /// preventing unnecessary network requests immediately after navigation.
  Future<void> preload(WebtritSystemInfo info);

  // TODO: Consider extracting this into a dedicated provider (e.g. `CoreUrlProvider`)
  // Exposing the core URL from the repository mixes configuration/transport concerns with the repository's data responsibilities.
  /// Returns the current Core URL used by the underlying remote data source.
  Uri getCoreUrl();

  /// Clears the locally cached system information.
  Future<void> clear();
}

final _logger = Logger('SystemInfoRepository');

class SystemInfoRepositoryImpl implements SystemInfoRepository {
  SystemInfoRepositoryImpl({required this.localDatasource, required this.remoteDatasource});

  final SystemInfoLocalDatasource localDatasource;

  final SystemInfoRemoteDatasource remoteDatasource;

  final _controller = StreamController<WebtritSystemInfo>.broadcast();

  Future<void> _updateSystemInfo(WebtritSystemInfo info) async {
    _controller.add(info);

    try {
      await localDatasource.setSystemInfo(info);
    } catch (e, s) {
      _logger.warning('Failed to save system info locally', e, s);
    }
  }

  @override
  Stream<WebtritSystemInfo> get infoStream => _controller.stream;

  @override
  Future<WebtritSystemInfo?> getSystemInfo({FetchPolicy fetchPolicy = FetchPolicy.cacheFirst}) async {
    switch (fetchPolicy) {
      case FetchPolicy.cacheFirst:
        return _getCacheFirstSystemInfoPolicy();
      case FetchPolicy.networkOnly:
        return _getNetworkSystemInfoPolicy();
      case FetchPolicy.cacheOnly:
        return _getCacheSystemInfoPolicy();
    }
  }

  @override
  Future<void> preload(WebtritSystemInfo info) async {
    _logger.info('Preloading system info from external source');
    await _updateSystemInfo(info);
  }

  /// Returns system info from the cache if available.
  ///
  /// Falls back to a network fetch when no cached value exists.
  /// The network path updates both the local cache and [infoStream]
  /// via [_getNetworkSystemInfoPolicy].
  Future<WebtritSystemInfo?> _getCacheFirstSystemInfoPolicy() async {
    _logger.fine('Fetching system info from cache first');
    final localInfo = await _getLocalSystemInfoOrNull();
    if (localInfo != null) {
      return localInfo;
    }

    return _getNetworkSystemInfoPolicy();
  }

  /// Fetches system info from the network and updates local state.
  ///
  /// Always overwrites the cached value and pushes the new data to
  /// [infoStream]. Used by refresh flows to ensure the system info is
  /// up to date even when cached data is present.
  Future<WebtritSystemInfo?> _getNetworkSystemInfoPolicy() async {
    _logger.fine('Fetching system info from network only');
    final remoteInfo = await _getRemoteSystemInfo();
    await _updateSystemInfo(remoteInfo);
    return remoteInfo;
  }

  /// Returns system info from the local cache only.
  ///
  /// Does not perform any network requests. If no cached value exists,
  /// returns `null`. Useful for lightweight reads where stale data is
  /// acceptable or when operating in offline mode.
  Future<WebtritSystemInfo?> _getCacheSystemInfoPolicy() async {
    _logger.fine('Fetching system info from cache only');
    return _getLocalSystemInfoOrNull();
  }

  Future<WebtritSystemInfo> _getRemoteSystemInfo() async {
    try {
      final remoteInfo = await remoteDatasource.getSystemInfo();

      _logger.fine('System info loaded from remote');
      return remoteInfo;
    } catch (e, s) {
      _logger.warning('Failed to fetch remote system info', e, s);
      rethrow;
    }
  }

  Future<WebtritSystemInfo?> _getLocalSystemInfoOrNull() async {
    try {
      final localInfo = localDatasource.getSystemInfo();
      if (localInfo == null) {
        _logger.fine('No system info found in local storage');
      } else {
        _logger.fine('System info loaded from local storage');
      }
      return localInfo;
    } catch (e, s) {
      _logger.warning('Failed to retrieve local system info', e, s);
      return null;
    }
  }

  @override
  Uri getCoreUrl() {
    return remoteDatasource.coreUrl;
  }

  @override
  Future<void> clear() async {
    _logger.info('Clearing system info');
    await localDatasource.clear();
  }

  @override
  Future<void> refresh() async {
    _logger.info('Background refresh started');
    try {
      await getSystemInfo(fetchPolicy: FetchPolicy.networkOnly);
    } catch (e, s) {
      _logger.warning('Background refresh failed', e, s);
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    await _controller.close();
  }
}
