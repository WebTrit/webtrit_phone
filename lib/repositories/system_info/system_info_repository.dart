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

  StreamSubscription? _remoteSubscription;
  StreamSubscription? _localSubscription;

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
    _localSubscription = localDatasource.infoStream.listen(
      (info) {
        if (info != null) {
          _controller.add(info);
        } else {
          _controller.addError('System info from local storage is not available.');
        }
      },
      onError: (e, s) {
        _logger.warning('Error in local system info stream', e, s);
      },
    );

    _remoteSubscription = remoteDatasource.infoUpdates.listen(
      (newInfo) {
        _saveToLocal(newInfo);
        // Do NOT call `_controller.add(newInfo)` here.
        // Saving to the local datasource triggers `localDatasource.infoStream`,
        // which is already forwarded to `_controller` by `_localSubscription`.
        // Emitting here would cause duplicate events.
      },
      onError: (e, s) {
        _logger.warning('Error in remote system info stream', e, s);
      },
    );
  }

  Future<void> _saveToLocal(WebtritSystemInfo info) async {
    _logger.info('Saving system info locally');

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
    _logger.info('Getting system info');

    try {
      final info = await remoteDatasource.getInfo(force);

      await _saveToLocal(info);

      return info;
    } catch (e) {
      final localInfo = localDatasource.getSystemInfo();
      if (localInfo != null && !force) {
        _logger.info('Remote fetch failed, returning local data fallback');
        return localInfo;
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
    _logger.info('Clearing system info');
    await localDatasource.clear();
  }

  @override
  Future<void> refresh() async {
    _logger.info('Background refresh started');
    try {
      await getSystemInfo(force: true);
    } catch (e, s) {
      _logger.warning('Background refresh failed', e, s);
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    await _remoteSubscription?.cancel();
    await _localSubscription?.cancel();
    await _controller.close();

    await remoteDatasource.dispose();
    await localDatasource.dispose();
  }
}
