import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/system_info/system_info_remote_datasource.dart';

import 'system_info_local_datasource.dart';

enum FetchPolicy {
  cacheFirst, // Try local cache first; if missing, fetch from server
  networkOnly, // Fetch only from server; do not use cache
  cacheOnly, // Use only local cache; do not contact server
}

abstract interface class SystemInfoRepository implements Refreshable, Disposable {
  Stream<WebtritSystemInfo> get infoStream;

  Future<WebtritSystemInfo?> getSystemInfo({FetchPolicy fetchPolicy = FetchPolicy.cacheFirst});

  // TODO: Consider extracting this into a dedicated provider (e.g. `CoreUrlProvider`)
  // Exposing the core URL from the repository mixes configuration/transport concerns with the repository's data responsibilities.
  Uri getCoreUrl();

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

  Future<WebtritSystemInfo> _getCacheFirstSystemInfoPolicy() async {
    _logger.fine('Fetching system info from cache first');
    final localInfo = await _getLocalSystemInfoOrNull();
    if (localInfo != null) {
      return localInfo;
    }

    final remoteInfo = await _getRemoteSystemInfo();
    _updateSystemInfo(remoteInfo);

    return remoteInfo;
  }

  Future<WebtritSystemInfo?> _getNetworkSystemInfoPolicy() async {
    _logger.fine('Fetching system info from network only');
    return _getRemoteSystemInfo();
  }

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
      await getSystemInfo();
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
