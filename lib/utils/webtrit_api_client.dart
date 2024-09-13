import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/data/data.dart';

typedef WebtritApiClientFactory = WebtritApiClient Function(String coreUrl, String tenantId);

WebtritApiClient defaultCreateWebtritApiClient(String coreUrl, String tenantId) {
  final appCertificates = AppCertificates();

  return WebtritApiClient(
    Uri.parse(coreUrl),
    tenantId,
    connectionTimeout: kApiClientConnectionTimeout,
    certs: appCertificates.trustedCertificates,
  );
}

LightHttpClient createApiClient() {
  final appCertificates = AppCertificates();

  return LightHttpClient(
    connectionTimeout: kApiClientConnectionTimeout,
    certs: appCertificates.trustedCertificates,
  );
}
