import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/common/common.dart';

final _logger = Logger('SystemInfoRepository');

class SystemInfoRepository with SystemInfoApiMapper implements Refreshable {
  SystemInfoRepository(this.webtritApiClient) {
    _updatesController = StreamController<WebtritSystemInfo>.broadcast();
  }

  final WebtritApiClient webtritApiClient;
  late final StreamController<WebtritSystemInfo> _updatesController;

  WebtritSystemInfo? _lastInfo;

  Future<WebtritSystemInfo> _gatherUserInfo() async {
    try {
      final apiSystemInfo = await webtritApiClient.getSystemInfo();
      final newInfo = systemInfoFromApi(apiSystemInfo);

      if (newInfo != _lastInfo) _updatesController.add(newInfo);
      _lastInfo = newInfo;
      return newInfo;
    } catch (e, stackTrace) {
      _logger.warning('_gatherSystemInfo', e, stackTrace);
      _updatesController.addError(e, stackTrace);
      rethrow;
    }
  }

  Future<WebtritSystemInfo> getInfo([bool force = false]) {
    if (force == false && _lastInfo != null) {
      return Future.value(_lastInfo);
    } else {
      return _gatherUserInfo();
    }
  }

  Stream<WebtritSystemInfo> get infoUpdates => _updatesController.stream;

  Uri get coreUrl => webtritApiClient.tenantUrl;

  @override
  Future<void> refresh() {
    return _gatherUserInfo();
  }
}
