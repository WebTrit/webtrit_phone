import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import 'package:ssl_certificates/ssl_certificates.dart';

http.Client createHttpClient({
  Duration? connectionTimeout,
  TrustedCertificates certs = TrustedCertificates.empty,
}) {
  SecurityContext? securityContext = initializeSecurityContext(certs);

  final customHttpClient = HttpClient(context: securityContext);
  customHttpClient.connectionTimeout = connectionTimeout;

  return IOClient(customHttpClient);
}
