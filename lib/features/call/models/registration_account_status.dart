import 'package:webtrit_signaling/webtrit_signaling.dart';

enum RegistrationAccountStatus {
  registering,
  registered,
  failed,
  unregistering,
  unregistered,
}

extension RegisterAccountStatusX on RegistrationAccountStatus {
  bool get isRegistering => this == RegistrationAccountStatus.registering;

  bool get isRegistered => this == RegistrationAccountStatus.registered;

  bool get isFailed => this == RegistrationAccountStatus.failed;

  bool get isUnregistering => this == RegistrationAccountStatus.unregistering;

  bool get isUnregistered => this == RegistrationAccountStatus.unregistered;
}

extension RegistrationStatusMapping on RegistrationStatus {
  RegistrationAccountStatus toRegistrationAccountStatus() {
    switch (this) {
      case RegistrationStatus.registering:
        return RegistrationAccountStatus.registering;
      case RegistrationStatus.registered:
        return RegistrationAccountStatus.registered;
      case RegistrationStatus.registration_failed:
        return RegistrationAccountStatus.failed;
      case RegistrationStatus.unregistering:
        return RegistrationAccountStatus.unregistering;
      case RegistrationStatus.unregistered:
        return RegistrationAccountStatus.unregistered;
      default:
        throw Exception('Unhandled RegistrationStatus: $this');
    }
  }
}
