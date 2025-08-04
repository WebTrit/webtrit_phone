import 'package:connectivity_plus/connectivity_plus.dart';

import 'webtrit_http_executor.dart';

abstract class ConnectivityChecker {
  Future<bool> checkConnection();
}

class DefaultConnectivityChecker implements ConnectivityChecker {
  const DefaultConnectivityChecker({
    this.connectivityCheckUrl = 'https://www.google.com/generate_204',
    this.createHttpRequestExecutor = defaultCreateHttpRequestExecutor,
  });

  final String connectivityCheckUrl;
  final HttpRequestExecutorFactory createHttpRequestExecutor;

  @override
  Future<bool> checkConnection() async {
    final result = await Connectivity().checkConnectivity();
    if (result.contains(ConnectivityResult.none) || result.isEmpty) {
      return false;
    }

    final executor = createHttpRequestExecutor();
    try {
      await executor.execute(method: 'GET', url: connectivityCheckUrl);
      return true;
    } catch (_) {
      return false;
    } finally {
      executor.close();
    }
  }
}
