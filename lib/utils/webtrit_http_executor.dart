import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/models/models.dart';

typedef HttpRequestExecutorFactory = Future<void> Function(EmbeddedUrlCallbackModel model);

Future<void> defaultCreateHttpRequestExecutor(EmbeddedUrlCallbackModel model) {
  final executor = HttpRequestExecutor();
  return executor.execute(
    method: model.method,
    url: model.url,
    headers: model.headers,
    data: model.data,
  );
}
