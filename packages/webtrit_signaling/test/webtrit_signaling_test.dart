import 'package:test/test.dart';

import 'package:webtrit_signaling/webtrit_signaling.dart';

void main() {
  const host = 'core.webtrit.com';

  group('buildTenantUrl', () {
    test('do not add tenant path segments for empty tenantId 1', () {
      final baseUrl = Uri(scheme: 'wss', host: host, path: '/');
      final tenantUrl = WebtritSignalingClient.buildTenantUrl(baseUrl, '');
      expect(tenantUrl.toString(), equals('wss://$host/'));
    });

    test('do not add tenant path segments for empty tenantId 2', () {
      final baseUrl = Uri(scheme: 'wss', host: host, path: '/path');
      final tenantUrl = WebtritSignalingClient.buildTenantUrl(baseUrl, '');
      expect(tenantUrl.toString(), equals('wss://$host/path'));
    });

    test('add tenant path segments for not empty tenantId 1', () {
      final baseUrl = Uri(scheme: 'wss', host: host, path: '/');
      final tenantUrl = WebtritSignalingClient.buildTenantUrl(baseUrl, 'tid');
      expect(tenantUrl.toString(), equals('wss://$host/tenant/tid'));
    });

    test('add tenant path segments for not empty tenantId 2', () {
      final baseUrl = Uri(scheme: 'wss', host: host, path: '/path');
      final tenantUrl = WebtritSignalingClient.buildTenantUrl(baseUrl, 'tid');
      expect(tenantUrl.toString(), equals('wss://$host/path/tenant/tid'));
    });

    test('do not update tenant path segments for empty tenantId 1', () {
      final baseUrl = Uri(scheme: 'wss', host: host, path: '/tenant/tid1');
      final tenantUrl = WebtritSignalingClient.buildTenantUrl(baseUrl, '');
      expect(tenantUrl.toString(), equals('wss://$host/tenant/tid1'));
    });

    test('do not update tenant path segments for empty tenantId 2', () {
      final baseUrl = Uri(scheme: 'wss', host: host, path: '/path/tenant/tid1');
      final tenantUrl = WebtritSignalingClient.buildTenantUrl(baseUrl, '');
      expect(tenantUrl.toString(), equals('wss://$host/path/tenant/tid1'));
    });

    test('update tenant path segments for not empty tenantId 1', () {
      final baseUrl = Uri(scheme: 'wss', host: host, path: '/tenant/tid1');
      final tenantUrl = WebtritSignalingClient.buildTenantUrl(baseUrl, 'tid2');
      expect(tenantUrl.toString(), equals('wss://$host/tenant/tid2'));
    });

    test('update tenant path segments for not empty tenantId 2', () {
      final baseUrl = Uri(scheme: 'wss', host: host, path: '/path/tenant/tid1');
      final tenantUrl = WebtritSignalingClient.buildTenantUrl(baseUrl, 'tid2');
      expect(tenantUrl.toString(), equals('wss://$host/path/tenant/tid2'));
    });

    test('update tenant path segments for not empty tenantId 3', () {
      final baseUrl = Uri(
          scheme: 'wss',
          host: host,
          path: '/path1/tenant/tid1/path2/tenant/tid2');
      final tenantUrl = WebtritSignalingClient.buildTenantUrl(baseUrl, 'tid3');
      expect(tenantUrl.toString(),
          equals('wss://$host/path1/tenant/tid1/path2/tenant/tid3'));
    });
  });
}
