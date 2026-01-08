import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';

final _logger = Logger('SystemInfoRepository');

/// Responsible for fetching [WebtritSystemInfo] from the remote API.
///
/// This datasource acts as a low-level abstraction over the HTTP client,
/// handling the raw request and mapping the response to the domain model
/// via [SystemInfoApiMapper].
class SystemInfoRemoteDatasource with SystemInfoApiMapper implements Disposable {
  SystemInfoRemoteDatasource(this.webtritApiClient);

  final WebtritApiClientFactory webtritApiClient;

  /// Retrieves the system information from the backend.
  ///
  /// By default, this utilizes the current configuration of [webtritApiClient].
  ///
  /// Optional parameters [overrideCoreUrl] and [overrideTenantId] can be provided
  /// to force the request to a specific server or tenant. This is typically used
  /// during server discovery or login flows (stateless checks) where the
  /// application session has not yet been established or updated.
  ///
  /// Throws an exception and logs a warning if the API call fails or mapping errors occur.
  Future<WebtritSystemInfo> getSystemInfo({Uri? overrideCoreUrl, String? overrideTenantId}) async {
    try {
      // Creates a client. If overrides are null, the factory uses the default/current configuration.
      final client = webtritApiClient.createWebtritApiClient(coreUrl: overrideCoreUrl, tenantId: overrideTenantId);

      final apiSystemInfo = await client.getSystemInfo();
      final newInfo = systemInfoFromApi(apiSystemInfo);

      return newInfo;
    } catch (e, stackTrace) {
      _logger.warning('Failed to gather system info from remote API', e, stackTrace);
      rethrow;
    }
  }

  /// Returns the default Core URL currently configured in the API client factory.
  Uri get coreUrl => webtritApiClient.createWebtritApiClient().tenantUrl;

  @override
  Future<void> dispose() async {
    return;
  }
}
