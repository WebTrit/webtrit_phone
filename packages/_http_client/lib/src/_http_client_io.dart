import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

http.Client createHttpClient({
  Duration? connectionTimeout,
  List<(List<int> bytes, String? password)> certs = const [],
}) {
  SecurityContext? securityContext;

  if (certs.isNotEmpty) {
    securityContext = SecurityContext();
    for (final cert in certs) {
      securityContext.setTrustedCertificatesBytes(cert.$1, password: cert.$2);
    }
  }

  final customHttpClient = HttpClient(context: securityContext);
  customHttpClient.connectionTimeout = connectionTimeout;

  return IOClient(customHttpClient);
}
