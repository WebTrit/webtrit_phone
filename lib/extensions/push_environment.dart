import 'package:google_api_availability/google_api_availability.dart';

/// A generic representation of the availability of a push notification system.
///
/// This enum mirrors `GooglePlayServicesAvailability` but is decoupled to allow for
/// future expansion or changes, such as supporting other push services (e.g., HMS for Huawei).
/// It provides a unified status that is not directly tied to a specific implementation.
enum PushSystemAvailability { success, missing, updating, updateRequired, disabled, invalid, notAvailable, unknown }

extension GmsAvailabilityX on PushSystemAvailability {
  bool get isAvailable => this == PushSystemAvailability.success;

  bool get isTerminal {
    return this == PushSystemAvailability.disabled ||
        this == PushSystemAvailability.invalid ||
        this == PushSystemAvailability.missing ||
        this == PushSystemAvailability.notAvailable ||
        this == PushSystemAvailability.updateRequired;
  }
}

extension GooglePlayServicesAvailabilityMapper on GooglePlayServicesAvailability {
  PushSystemAvailability toAppStatus() {
    switch (this) {
      case GooglePlayServicesAvailability.success:
        return PushSystemAvailability.success;
      case GooglePlayServicesAvailability.serviceMissing:
        return PushSystemAvailability.missing;
      case GooglePlayServicesAvailability.serviceUpdating:
        return PushSystemAvailability.updating;
      case GooglePlayServicesAvailability.serviceVersionUpdateRequired:
        return PushSystemAvailability.updateRequired;
      case GooglePlayServicesAvailability.serviceDisabled:
        return PushSystemAvailability.disabled;
      case GooglePlayServicesAvailability.serviceInvalid:
        return PushSystemAvailability.invalid;
      case GooglePlayServicesAvailability.unknown:
      default:
        return PushSystemAvailability.unknown;
    }
  }
}
