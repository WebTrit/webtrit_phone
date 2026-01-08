import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

final _logger = Logger('ConnectivityService');

abstract class ConnectivityChecker {
  Future<bool> checkConnection();

  Future<void> dispose();
}

class DefaultConnectivityChecker implements ConnectivityChecker {
  const DefaultConnectivityChecker({required this.connectivityCheckUrl, required this.createHttpRequestExecutor});

  /// Connectivity check URL.
  final String? connectivityCheckUrl;

  /// HTTP request executor instance.
  final HttpRequestExecutor createHttpRequestExecutor;

  /// Default URL used for connectivity checks if no custom URL is provided.
  String get _defaultUrlProvider => 'https://www.google.com/generate_204';

  @override
  Future<bool> checkConnection() async {
    _logger.finest('Checking connectivity with URL: $connectivityCheckUrl');
    final result = await Connectivity().checkConnectivity();
    if (result.contains(ConnectivityResult.none) || result.isEmpty) {
      return false;
    }

    final url = connectivityCheckUrl ?? _defaultUrlProvider;

    try {
      await createHttpRequestExecutor.execute(method: 'GET', url: url);
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
