import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

http.Client createHttpClient({
  Duration? connectionTimeout,
}) {
  final customHttpClient = HttpClient();
  customHttpClient.connectionTimeout = connectionTimeout;

  return IOClient(customHttpClient);
}
