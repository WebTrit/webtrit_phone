import 'package:google_api_availability/google_api_availability.dart';

enum GmsAvailability { success, missing, updating, updateRequired, disabled, invalid, notAvailable, unknown }

extension GmsAvailabilityX on GmsAvailability {
  bool get isAvailable => this == GmsAvailability.success;

  bool get isTerminal {
    return this == GmsAvailability.disabled ||
        this == GmsAvailability.invalid ||
        this == GmsAvailability.missing ||
        this == GmsAvailability.notAvailable ||
        this == GmsAvailability.updateRequired;
  }
}

extension GooglePlayServicesAvailabilityMapper on GooglePlayServicesAvailability {
  GmsAvailability toAppStatus() {
    switch (this) {
      case GooglePlayServicesAvailability.success:
        return GmsAvailability.success;
      case GooglePlayServicesAvailability.serviceMissing:
        return GmsAvailability.missing;
      case GooglePlayServicesAvailability.serviceUpdating:
        return GmsAvailability.updating;
      case GooglePlayServicesAvailability.serviceVersionUpdateRequired:
        return GmsAvailability.updateRequired;
      case GooglePlayServicesAvailability.serviceDisabled:
        return GmsAvailability.disabled;
      case GooglePlayServicesAvailability.serviceInvalid:
        return GmsAvailability.invalid;
      case GooglePlayServicesAvailability.unknown:
      default:
        return GmsAvailability.unknown;
    }
  }
}
