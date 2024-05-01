import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart';

import 'package:ssl_certificates/ssl_certificates.dart';

import 'package:webtrit_phone/app/assets.gen.dart';

final Logger _logger = Logger('AppCertificates');

class AppCertificates {
  AppCertificates._(this._trustedCertificates);

  factory AppCertificates() => _instance;

  static late AppCertificates _instance;

  final TrustedCertificates _trustedCertificates;

  /// Returns the list of ssl certificates and their passwords.
  TrustedCertificates get trustedCertificates => _trustedCertificates;

  /// Initialize the AppCerts instance with the certificates
  static Future<void> init() async {
    final certificatePaths = Assets.certificates.values.where((it) => it != Assets.certificates.credentials);
    final credentialsPath = Assets.certificates.credentials;

    final credentials = await _loadCredentials(credentialsPath);
    final certificates = await Future.wait(certificatePaths.map((it) => _prepareCertificate(it, credentials)));

    _instance = AppCertificates._(
      TrustedCertificates(
        certificates: certificates,
      ),
    );
  }

  /// Loads certificate bytes from assets using the provided path and credentials.
  static Future<TrustCertificate> _prepareCertificate(String path, Map<String, dynamic> credentials) async {
    final certificate = await _loadCertificate(path);
    final certificateName = basename(path);
    final certificatePassword = credentials[certificateName] as String?;

    return TrustCertificate(bytes: certificate, password: certificatePassword);
  }

  /// Loads certificate bytes from assets using the provided path.
  static Future<List<int>> _loadCertificate(String path) async {
    final sslCert = await rootBundle.load(path);
    return sslCert.buffer.asUint8List();
  }

  /// Loads credentials from a JSON file in assets using the provided path.
  static Future<Map<String, dynamic>> _loadCredentials(String path) async {
    final jsonString = await rootBundle.loadString(path);
    final map = jsonDecode(jsonString) as Map<String, dynamic>;
    return map;
  }
}
