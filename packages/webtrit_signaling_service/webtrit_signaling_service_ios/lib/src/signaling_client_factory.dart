import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

typedef SignalingClientFactory =
    Future<WebtritSignalingClient> Function({
      required Uri url,
      required String tenantId,
      required String token,
      required Duration connectionTimeout,
      required TrustedCertificates certs,
      required bool force,
    });

Future<WebtritSignalingClient> defaultSignalingClientFactory({
  required Uri url,
  required String tenantId,
  required String token,
  required Duration connectionTimeout,
  required TrustedCertificates certs,
  required bool force,
}) {
  return WebtritSignalingClient.connect(
    url,
    tenantId,
    token,
    force,
    connectionTimeout: connectionTimeout,
    certs: certs,
  );
}
