import 'package:google_api_availability/google_api_availability.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/utils/utils.dart';

export 'package:webtrit_phone/extensions/push_environment.dart';

final Logger _logger = Logger('PushEnvironment');

class PushEnvironment {
  final GoogleApiAvailability _googleApiAvailability;

  PushEnvironment._(this._googleApiAvailability);

  static Future<PushEnvironment> init() async {
    return PushEnvironment._(GoogleApiAvailability.instance);
  }

  Future<GmsAvailability> getAvailability() async {
    // On iOS, we don't have GMS, but the Push Environment (APNs) is valid.
    // We return 'success' so the Bloc proceeds to fetch the token.
    if (PlatformInfo.isIOS) {
      return GmsAvailability.success;
    }

    // For other non-Android platforms (e.g., Windows, macOS, Web if not supported)
    if (!PlatformInfo.isAndroid) {
      return GmsAvailability.notAvailable;
    }

    _logger.info('Checking Google Play Services availability...');

    GooglePlayServicesAvailability playStoreAvailability;
    try {
      playStoreAvailability = await _googleApiAvailability.checkGooglePlayServicesAvailability();
    } catch (e) {
      _logger.warning('Error checking GMS: $e');
      return GmsAvailability.unknown;
    }

    final status = playStoreAvailability.toAppStatus();
    _logger.info('GMS Status snapshot: $status');

    return status;
  }
}
