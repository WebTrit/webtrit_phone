import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';

import 'webtrit_http_executor.dart';

final _logger = Logger('ConnectivityService');

abstract class ConnectivityChecker {
  Future<bool> checkConnection();

  Future<void> dispose();
}

class DefaultConnectivityChecker implements ConnectivityChecker {
  const DefaultConnectivityChecker({
    required this.connectivityCheckUrl,
    this.createHttpRequestExecutor = defaultCreateHttpRequestExecutor,
  });

  /// Connectivity check URL.
  final String? connectivityCheckUrl;

  /// Factory to create an HTTP request executor.
  final HttpRequestExecutorFactory createHttpRequestExecutor;

  /// Default URL used for connectivity checks if no custom URL is provided.
  String get _defaultUrlProvider => 'https://www.google.com/generate_204';

  @override
  Future<bool> checkConnection() async {
    _logger.finest('Checking connectivity with URL: $connectivityCheckUrl');
    final result = await Connectivity().checkConnectivity();
    if (result.contains(ConnectivityResult.none) || result.isEmpty) {
      return false;
    }

    final executor = createHttpRequestExecutor();
    final url = connectivityCheckUrl ?? _defaultUrlProvider;

    try {
      await executor.execute(method: 'GET', url: url);
      _logger.finest('Connectivity check successful with URL: $url');
      return true;
    } catch (_) {
      _logger.finest('Connectivity check failed with URL: $url');
      return false;
    }
  }

  @override
  Future<void> dispose() async {
    createHttpRequestExecutor.close();
  }
}
