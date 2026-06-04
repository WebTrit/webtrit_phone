import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

final _logger = Logger('ConnectivityService');

abstract class ConnectivityChecker {
  Future<bool> checkConnection();

  Future<void> dispose();
}

class DefaultConnectivityChecker implements ConnectivityChecker {
  const DefaultConnectivityChecker({required this.createApiClient});

  /// Resolves a [WebtritApiClient] bound to the *current* session core URL on
  /// each probe. Resolving lazily on every check (instead of capturing a single
  /// client at construction) keeps the liveness probe following the active
  /// session after login or a core-URL switch, rather than sticking to the
  /// bootstrap-time default URL.
  final WebtritApiClient Function() createApiClient;

  @override
  Future<bool> checkConnection() async {
    _logger.finest('Checking connectivity via API client.');
    try {
      await createApiClient().healthCheck();
      _logger.finest('API connectivity check successful.');
      return true;
    } catch (e) {
      _logger.finest('API connectivity check failed: $e');
      return false;
    }
  }

  @override
  Future<void> dispose() async {
    createApiClient().close();
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
    } catch (e) {
      _logger.finest('Connectivity check failed with URL: $connectivityCheckUrl: $e');
      return false;
    }
  }

  @override
  Future<void> dispose() async {
    createHttpRequestExecutor.close();
  }
}
