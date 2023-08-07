library;

import 'package:http/http.dart' as http;

import 'src/_http_client_stub.dart'
    if (dart.library.html) 'src/_http_client_html.dart'
    if (dart.library.io) 'src/_http_client_io.dart' as platform;

http.Client createHttpClient({
  Duration? connectionTimeout,
}) {
  return platform.createHttpClient(connectionTimeout: connectionTimeout);
}
