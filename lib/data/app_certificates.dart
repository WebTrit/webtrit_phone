import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:logging/logging.dart';
import 'package:path/path.dart';

import 'package:ssl_certificates/ssl_certificates.dart';

import 'package:webtrit_phone/app/assets.gen.dart';

final _logger = Logger('AppCertificates');

class AppCertificates {
  AppCertificates._(this._trustedCertificates);

  final TrustedCertificates _trustedCertificates;

  /// Returns the list of ssl certificates and their passwords.
  TrustedCertificates get trustedCertificates => _trustedCertificates;

  /// Initialize the AppCerts instance with the certificates.
  ///
  /// Returns [TrustedCertificates.empty] when the certificate assets are not
  /// bundled — e.g. when the app runs embedded inside another host (the theme
  /// configurator's realtime preview) whose asset bundle does not include this
  /// package's `assets/certificates/...`. Custom CA pinning is then unavailable
  /// and the platform trust store is used instead.
  static Future<AppCertificates> init() async {
    try {
      final certificatePaths = Assets.certificates.values.where((it) => it != Assets.certificates.credentials);
      final credentialsPath = Assets.certificates.credentials;

      final credentials = await _loadCredentials(credentialsPath);
      final certificates = await Future.wait(certificatePaths.map((it) => _prepareCertificate(it, credentials)));

      return AppCertificates._(TrustedCertificates(certificates: certificates));
    } catch (e, s) {
      _logger.warning('Trusted certificate assets unavailable; continuing without custom CA certificates', e, s);
      return AppCertificates._(TrustedCertificates.empty);
    }
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
