import 'package:flutter/foundation.dart';

import 'package:ssl_certificates/ssl_certificates.dart';

import 'package:webtrit_api/webtrit_api.dart';
import 'package:webtrit_phone/app/constants.dart';

typedef CoreUrlCallback = Uri Function();
typedef TenantIdCallback = String Function();

class WebtritApiClientFactory {
  WebtritApiClientFactory({
    required this.getTenantId,
    required this.getCoreUrl,
    required this.trustedCertificates,
    this.userAgent,
  });

  final CoreUrlCallback getCoreUrl;
  final TenantIdCallback getTenantId;
  final TrustedCertificates trustedCertificates;

  /// Sent as the `User-Agent` header, so the session the backend creates on
  /// login is labelled with this app build and device.
  final String? userAgent;

  WebtritApiClient? _cachedClient;
  Uri? _lastCoreUrl;
  String? _lastTenantId;

  WebtritApiClient createWebtritApiClient({Uri? coreUrl, String? tenantId}) {
    final actualCoreUrl = coreUrl ?? getCoreUrl();
    final actualTenantId = tenantId ?? getTenantId();

    if (_cachedClient != null &&
        _lastCoreUrl.toString() == actualCoreUrl.toString() &&
        _lastTenantId == actualTenantId) {
      return _cachedClient!;
    }

    final newClient = WebtritApiClient(
      actualCoreUrl,
      actualTenantId,
      connectionTimeout: kApiClientConnectionTimeout,
      certs: trustedCertificates,
      isDebug: kDebugMode,
      userAgent: userAgent,
    );

    _cachedClient = newClient;
    _lastCoreUrl = actualCoreUrl;
    _lastTenantId = actualTenantId;

    return newClient;
  }

  HttpRequestExecutor createHttpRequestExecutor() {
    return HttpRequestExecutor();
  }
}
