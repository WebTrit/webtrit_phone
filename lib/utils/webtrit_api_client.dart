import 'package:webtrit_api/webtrit_api.dart';

import 'package:ssl_certificates/ssl_certificates.dart';

import 'package:webtrit_phone/app/constants.dart';

typedef WebtritApiClientFactory =
    WebtritApiClient Function(String coreUrl, String tenantId, {TrustedCertificates trustedCertificates});

WebtritApiClient defaultCreateWebtritApiClient(
  String coreUrl,
  String tenantId, {
  TrustedCertificates trustedCertificates = TrustedCertificates.empty,
}) {
  return WebtritApiClient(
    Uri.parse(coreUrl),
    tenantId,
    connectionTimeout: kApiClientConnectionTimeout,
    certs: trustedCertificates,
  );
}
