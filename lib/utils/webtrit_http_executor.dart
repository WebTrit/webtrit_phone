import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/models/models.dart';

typedef HttpRequestExecutorFactory = Future<void> Function(RawHttpRequest request);

Future<dynamic> defaultCreateHttpRequestExecutor(RawHttpRequest request) {
  final executor = HttpRequestExecutor();
  return executor.execute(
    method: request.method,
    url: request.url,
    headers: request.headers,
    data: request.data,
  );
}
