import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/system_info/system_info_remote_datasource.dart';

import 'system_info_local_datasource.dart';

abstract interface class SystemInfoRepository implements Refreshable, Disposable {
  Stream<WebtritSystemInfo> get infoStream;

  Future<WebtritSystemInfo?> getSystemInfo({bool force = false});

  // TODO: Consider extracting this into a dedicated provider (e.g. `CoreUrlProvider`)
  // Exposing the core URL from the repository mixes configuration/transport concerns with the repository's data responsibilities.
  Uri getCoreUrl();

  Future<void> clear();
}

final _logger = Logger('SystemInfoRepository');

class SystemInfoRepositoryImpl implements SystemInfoRepository {
  SystemInfoRepositoryImpl({required this.localDatasource, required this.remoteDatasource}) {
    _init();
  }

  final SystemInfoLocalDatasource localDatasource;
  final SystemInfoRemoteDatasource remoteDatasource;

  final _controller = StreamController<WebtritSystemInfo>.broadcast();

  void _init() {
    _logger.info('Initializing system info repository');
    try {
      final localInfo = localDatasource.getSystemInfo();
      if (localInfo != null) {
        _controller.add(localInfo);
      } else {
        _controller.addError('Failed to load system info from local storage');
      }
    } catch (e, s) {
      _logger.warning('Failed to load initial local system info', e, s);
    }
  }

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
  Future<WebtritSystemInfo?> getSystemInfo({bool force = false}) async {
    _logger.info('Getting system info (force: $force)');

    if (!force) {
      try {
        final localInfo = localDatasource.getSystemInfo();
        if (localInfo != null) {
          return localInfo;
        }
      } catch (e, s) {
        _logger.warning('Failed to retrieve local system info', e, s);
      }
    }

    try {
      final remoteInfo = await remoteDatasource.getSystemInfo();

      await _updateSystemInfo(remoteInfo);

      return remoteInfo;
    } catch (e) {
      if (force) {
        final localInfo = localDatasource.getSystemInfo();
        if (localInfo != null) {
          _logger.info('Remote fetch failed, returning local data fallback');
          return localInfo;
        }
      }
      rethrow;
    }
  }

  @override
  Uri getCoreUrl() {
    return remoteDatasource.coreUrl;
  }

  @override
  Future<void> clear() async {
    await localDatasource.clear();
  }

  @override
  Future<void> refresh() async {
    try {
      await getSystemInfo(force: true);
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
