import 'dart:io';

import 'package:_http_client/src/res/test.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

http.Client createHttpClient({
  Duration? connectionTimeout,
}) {
  SecurityContext context = SecurityContext();

  context.setTrustedCertificatesBytes(test);

  final customHttpClient = HttpClient(context: context);
  customHttpClient.badCertificateCallback = (X509Certificate cert, String host, int port) {
    print("!!!!Bad certificate");
    return false;
  };

  customHttpClient.connectionTimeout = connectionTimeout;

  return IOClient(customHttpClient);
}
