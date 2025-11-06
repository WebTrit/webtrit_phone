import 'dart:io';

import 'trusted_certificates.dart';

SecurityContext? initializeSecurityContext(TrustedCertificates trustedCertificates) {
  if (!trustedCertificates.hasAvailableCertificates) return null;

  final securityContext = SecurityContext(withTrustedRoots: true);

  for (final cert in trustedCertificates.certificates) {
    securityContext.setTrustedCertificatesBytes(cert.bytes, password: cert.password);
  }

  return securityContext;
}
