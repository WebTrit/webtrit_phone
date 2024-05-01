import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;

import 'package:ssl_certificates/ssl_certificates.dart' show TrustedCertificates;

http.Client createHttpClient({
  Duration? connectionTimeout,
  TrustedCertificates certs = TrustedCertificates.empty,
}) {
  return BrowserClient();
}
