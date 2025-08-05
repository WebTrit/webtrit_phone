import 'package:connectivity_plus/connectivity_plus.dart';

import 'webtrit_http_executor.dart';

abstract class ConnectivityChecker {
  Future<bool> checkConnection();
}

class DefaultConnectivityChecker implements ConnectivityChecker {
  const DefaultConnectivityChecker({
    required this.connectivityCheckUrlProvider,
    this.createHttpRequestExecutor = defaultCreateHttpRequestExecutor,
  });

  /// Callback to provide the connectivity check URL at runtime.
  /// Allows dynamic config (e.g. from env or user settings).
  final String? Function() connectivityCheckUrlProvider;

  /// Factory to create an HTTP request executor.
  final HttpRequestExecutorFactory createHttpRequestExecutor;

  /// Default URL used for connectivity checks if no custom URL is provided.
  String get _defaultUrlProvider => 'https://www.google.com/generate_204';

  @override
  Future<bool> checkConnection() async {
    final result = await Connectivity().checkConnectivity();
    if (result.contains(ConnectivityResult.none) || result.isEmpty) {
      return false;
    }

    final executor = createHttpRequestExecutor();
    final url = connectivityCheckUrlProvider() ?? _defaultUrlProvider;

    try {
      await executor.execute(method: 'GET', url: url);
      return true;
    } catch (_) {
      return false;
    } finally {
      executor.close();
    }
  }
}
