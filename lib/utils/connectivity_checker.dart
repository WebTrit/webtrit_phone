import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

final _logger = Logger('ConnectivityService');

abstract class ConnectivityChecker {
  Future<bool> checkConnection();

  Future<void> dispose();
}

class DefaultConnectivityChecker implements ConnectivityChecker {
  const DefaultConnectivityChecker({required this.apiClient});

  /// API client instance.
  final WebtritApiClient apiClient;

  @override
  Future<bool> checkConnection() async {
    _logger.finest('Checking connectivity via API client.');
    try {
      await apiClient.healthCheck();
      _logger.finest('API connectivity check successful.');
      return true;
    } catch (_) {
      _logger.finest('API connectivity check failed.');
      return false;
    }
  }

  @override
  Future<void> dispose() async {
    apiClient.close();
  }
}

class CustomConnectivityChecker implements ConnectivityChecker {
  const CustomConnectivityChecker({required this.connectivityCheckUrl, required this.createHttpRequestExecutor});

  /// Connectivity check URL.
  final String connectivityCheckUrl;

  /// HTTP request executor instance.
  final HttpRequestExecutor createHttpRequestExecutor;

  @override
  Future<bool> checkConnection() async {
    _logger.finest('Checking connectivity with URL: $connectivityCheckUrl');
    final result = await Connectivity().checkConnectivity();
    if (result.contains(ConnectivityResult.none) || result.isEmpty) {
      return false;
    }

    try {
      await createHttpRequestExecutor.execute(method: 'GET', url: connectivityCheckUrl);
      _logger.finest('Connectivity check successful with URL: $connectivityCheckUrl');
      return true;
    } catch (_) {
      _logger.finest('Connectivity check failed with URL: $connectivityCheckUrl');
      return false;
    }
  }

  @override
  Future<void> dispose() async {
    createHttpRequestExecutor.close();
  }
}
