import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

http.Client createHttpClient({
  Duration? connectionTimeout,
  List<int>? certBytes,
  String? certPassword,
}) {
  SecurityContext? securityContext;

  if (certBytes != null) {
    securityContext = SecurityContext();
    securityContext.setTrustedCertificatesBytes(certBytes, password: certPassword);
  }

  final customHttpClient = HttpClient(context: securityContext);
  customHttpClient.connectionTimeout = connectionTimeout;

  return IOClient(customHttpClient);
}
