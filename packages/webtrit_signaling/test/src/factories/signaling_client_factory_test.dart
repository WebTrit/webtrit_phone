import 'package:_web_socket_channel/_web_socket_channel.dart';

import 'package:test/test.dart';

import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'fake_webtrit_signaling.dart';

void main() {
  group('SignalingClientFactory', () {
    final testUri = Uri.parse('wss://signaling.example.com');
    const testTenantId = 'tenant';
    const testToken = 'token';
    const testTimeout = Duration(seconds: 10);
    final testCerts = TrustedCertificates();

    test('defaultSignalingClientFactory returns WebtritSignalingClient',
        () async {
      final client = await testSignalingClientFactory(
        url: testUri,
        tenantId: testTenantId,
        token: testToken,
        connectionTimeout: testTimeout,
        certs: testCerts,
        force: false,
      );

      expect(client, isA<WebtritSignalingClient>());
    });

    test('custom factory returns mock client', () async {
      Future<WebtritSignalingClient> fakeFactory({
        required Uri url,
        required String tenantId,
        required String token,
        required Duration connectionTimeout,
        required TrustedCertificates certs,
        required bool force,
      }) async {
        return FakeWebtritSignalingClient();
      }

      final client = await fakeFactory(
        url: testUri,
        tenantId: testTenantId,
        token: testToken,
        connectionTimeout: testTimeout,
        certs: testCerts,
        force: true,
      );

      expect(client, isA<FakeWebtritSignalingClient>());
    });

    test('factory passes all arguments correctly', () async {
      Uri? receivedUrl;
      String? receivedTenantId;
      String? receivedToken;
      Duration? receivedTimeout;
      TrustedCertificates? receivedCerts;
      bool? receivedForce;

      Future<WebtritSignalingClient> checkingFactory({
        required Uri url,
        required String tenantId,
        required String token,
        required Duration connectionTimeout,
        required TrustedCertificates certs,
        required bool force,
      }) async {
        receivedUrl = url;
        receivedTenantId = tenantId;
        receivedToken = token;
        receivedTimeout = connectionTimeout;
        receivedCerts = certs;
        receivedForce = force;
        return FakeWebtritSignalingClient();
      }

      await checkingFactory(
        url: testUri,
        tenantId: testTenantId,
        token: testToken,
        connectionTimeout: testTimeout,
        certs: testCerts,
        force: true,
      );

      expect(receivedUrl, testUri);
      expect(receivedTenantId, testTenantId);
      expect(receivedToken, testToken);
      expect(receivedTimeout, testTimeout);
      expect(receivedCerts, testCerts);
      expect(receivedForce, isTrue);
    });
  });
}
