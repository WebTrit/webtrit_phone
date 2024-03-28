import 'package:flutter/services.dart';
import 'package:webtrit_phone/environment_config.dart';

const kCertPath = 'assets/certificates/';

class AppCerts {
  static late AppCerts _instance;

  static Future<List<int>> _loadCertificate(String filename) async {
    final sslCert = await rootBundle.load('$kCertPath$filename');
    return sslCert.buffer.asUint8List();
  }

  static Future<void> init() async {
    String? sslCertFile = EnvironmentConfig.SSL_CERT_FILE;
    if (sslCertFile is String && sslCertFile.isEmpty) sslCertFile = null;

    String? sslCertPassword = EnvironmentConfig.SSL_CERT_PASSWORD;
    if (sslCertPassword is String && sslCertPassword.isEmpty) sslCertPassword = null;

    List<int>? sslCertBytes;

    if (sslCertFile != null) sslCertBytes = await _loadCertificate(sslCertFile);

    _instance = AppCerts._(sslCertBytes, sslCertPassword);
  }

  factory AppCerts() => _instance;

  AppCerts._(this._sslCertBytes, this._sslCertPassword);

  List<int>? _sslCertBytes;
  String? _sslCertPassword;

  /// Public ssl certificate for secure connection
  List<int>? get sslCertBytes => _sslCertBytes;

  /// Password for ssl certificate, will be ignored for PEM certs
  String? get sslCertPassword => _sslCertPassword;
}
