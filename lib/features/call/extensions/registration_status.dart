import 'package:webtrit_signaling/webtrit_signaling.dart';

extension RegisterStatusX on RegistrationStatus {
  bool get isRegistering => this == RegistrationStatus.registering;

  bool get isRegistered => this == RegistrationStatus.registered;

  bool get isFailed => this == RegistrationStatus.registration_failed;

  bool get isUnregistering => this == RegistrationStatus.unregistering;

  bool get isUnregistered => this == RegistrationStatus.unregistered;
}
