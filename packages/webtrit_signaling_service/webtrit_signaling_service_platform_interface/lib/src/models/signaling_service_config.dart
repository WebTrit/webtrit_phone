import 'package:ssl_certificates/ssl_certificates.dart';

/// Connection parameters for the signaling service.
class SignalingServiceConfig {
  const SignalingServiceConfig({
    required this.coreUrl,
    required this.tenantId,
    required this.token,
    this.trustedCertificates = TrustedCertificates.empty,
  });

  final String coreUrl;
  final String tenantId;
  final String token;
  final TrustedCertificates trustedCertificates;
}
