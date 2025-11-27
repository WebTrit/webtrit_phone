import 'dart:io';

import 'package:flutter/services.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:logging/logging.dart';

final Logger _logger = Logger('PushEnvironment');

class PushEnvironment {
  static late PushEnvironment _instance;

  final bool _isGmsCapableDevice;

  final bool _googlePlayAvailability;

  bool get isGmsCapableDevice => _isGmsCapableDevice;

  bool get googlePlayAvailability => _googlePlayAvailability;

  static Future<PushEnvironment> init() async {
    final isGmsCapableDevice = Platform.isAndroid;
    _logger.info('Checking if a device is an Android');

    final googlePlayAvailability = await canUseGmsPush();
    _logger.info('Checking play services availability status');

    _instance = PushEnvironment._(isGmsCapableDevice, googlePlayAvailability);
    return _instance;
  }

  factory PushEnvironment() {
    return _instance;
  }

  PushEnvironment._(this._isGmsCapableDevice, this._googlePlayAvailability);

  static Future<bool> canUseGmsPush() async {
    GooglePlayServicesAvailability playStoreAvailability;
    try {
      playStoreAvailability = await GoogleApiAvailability.instance
          .checkGooglePlayServicesAvailability();
    } on PlatformException {
      playStoreAvailability = GooglePlayServicesAvailability.unknown;
    }

    return playStoreAvailability == GooglePlayServicesAvailability.success;
  }
}
