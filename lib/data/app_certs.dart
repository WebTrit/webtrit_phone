import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:webtrit_phone/app/assets.gen.dart';

typedef CertsData = (List<int> bytes, String? password);

class AppCerts {
  AppCerts._(this._certs);
  factory AppCerts() => _instance;

  static late AppCerts _instance;
  List<CertsData> _certs = [];

  /// Returns the list of ssl certificates and their passwords.
  List<CertsData> get certs => _certs;

  /// Initialize the AppCerts instance with the certificatess
  static Future<void> init() async {
    const certAssets = Assets.certificates;

    // Load the credentials file
    // This file contains the passwords for the certificates as key-value pairs
    // The key is the name of the certificate file
    final credFile = await rootBundle.loadString(certAssets.credentials);
    final credData = jsonDecode(credFile);

    // Make a list of all the certificates except the credentials file
    final certsPaths = certAssets.values.where((path) => path != certAssets.credentials);

    // Load the certificates and find their passwords
    List<CertsData> certs = [];
    for (final path in certsPaths) {
      final bytes = await _loadCertificate(path);
      final fileSegments = path.split('/').last;
      final password = credData[fileSegments];
      certs.add((bytes, password));
    }

    // Initialize instance with the certificates
    _instance = AppCerts._(certs);
  }

  /// Load the certificate as bytes from the assets
  static Future<List<int>> _loadCertificate(String path) async {
    final sslCert = await rootBundle.load(path);
    return sslCert.buffer.asUint8List();
  }
}
