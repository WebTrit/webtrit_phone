class TrustedCertificates {
  static const TrustedCertificates empty =
      TrustedCertificates._internal(certificates: []);

  const TrustedCertificates._internal({
    required this.certificates,
  });

  factory TrustedCertificates({
    List<TrustCertificate> certificates = const [],
  }) {
    return TrustedCertificates._internal(certificates: certificates);
  }

  final List<TrustCertificate> certificates;

  bool get hasAvailableCertificates => certificates.isNotEmpty;
}

class TrustCertificate {
  const TrustCertificate._internal({
    required this.bytes,
    required this.password,
  });

  factory TrustCertificate({
    required List<int> bytes,
    String? password,
  }) {
    if (bytes.isEmpty) {
      throw ArgumentError('certificate cannot be empty');
    }

    return TrustCertificate._internal(bytes: bytes, password: password);
  }

  final List<int> bytes;
  final String? password;
}
