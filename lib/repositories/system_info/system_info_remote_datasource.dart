import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';

final _logger = Logger('SystemInfoRepository');

class SystemInfoRemoteDatasource with SystemInfoApiMapper implements Disposable {
  SystemInfoRemoteDatasource(this.webtritApiClient);

  final WebtritApiClientFactory webtritApiClient;

  Future<WebtritSystemInfo> getSystemInfo() async {
    try {
      final apiSystemInfo = await webtritApiClient.createWebtritApiClient().getSystemInfo();
      final newInfo = systemInfoFromApi(apiSystemInfo);
      return newInfo;
    } catch (e, stackTrace) {
      _logger.warning('Failed to gather system info from remote API', e, stackTrace);
      rethrow;
    }
  }

  Uri get coreUrl => webtritApiClient.createWebtritApiClient().tenantUrl;

  @override
  Future<void> dispose() async {
    return;
  }
}
