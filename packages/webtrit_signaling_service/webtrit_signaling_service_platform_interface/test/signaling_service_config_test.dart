import 'package:flutter_test/flutter_test.dart';
import 'package:ssl_certificates/ssl_certificates.dart';

import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

void main() {
  group('SignalingServiceConfig', () {
    test('stores all required fields', () {
      const config = SignalingServiceConfig(
        coreUrl: 'https://core.example.com',
        tenantId: 'tenant-42',
        token: 'secret-token',
      );

      expect(config.coreUrl, 'https://core.example.com');
      expect(config.tenantId, 'tenant-42');
      expect(config.token, 'secret-token');
    });

    test('trustedCertificates defaults to TrustedCertificates.empty', () {
      const config = SignalingServiceConfig(coreUrl: 'https://core.example.com', tenantId: 'tenant-1', token: 'tok');

      expect(config.trustedCertificates, same(TrustedCertificates.empty));
    });

    test('accepts custom TrustedCertificates', () {
      const certs = TrustedCertificates.empty;
      const config = SignalingServiceConfig(
        coreUrl: 'https://core.example.com',
        tenantId: 'tenant-1',
        token: 'tok',
        trustedCertificates: certs,
      );

      expect(config.trustedCertificates, same(certs));
    });

    test('is const-constructible', () {
      const config1 = SignalingServiceConfig(coreUrl: 'https://a.com', tenantId: 'a', token: 't');
      const config2 = SignalingServiceConfig(coreUrl: 'https://a.com', tenantId: 'a', token: 't');

      // const objects with same values are identical in Dart.
      expect(identical(config1, config2), isTrue);
    });

    test('accepts empty strings for all string fields', () {
      const config = SignalingServiceConfig(coreUrl: '', tenantId: '', token: '');

      expect(config.coreUrl, isEmpty);
      expect(config.tenantId, isEmpty);
      expect(config.token, isEmpty);
    });

    test('coreUrl with http scheme is stored verbatim', () {
      const config = SignalingServiceConfig(coreUrl: 'http://internal.example.com', tenantId: 'tenant', token: 'tok');

      expect(config.coreUrl, startsWith('http://'));
    });

    test('coreUrl with https scheme is stored verbatim', () {
      const config = SignalingServiceConfig(coreUrl: 'https://secure.example.com', tenantId: 'tenant', token: 'tok');

      expect(config.coreUrl, startsWith('https://'));
    });
  });
}
