import 'package:webtrit_api/webtrit_api.dart';

typedef HttpRequestExecutorFactory = HttpRequestExecutor Function();

HttpRequestExecutor defaultCreateHttpRequestExecutor() {
  return HttpRequestExecutor();
}
