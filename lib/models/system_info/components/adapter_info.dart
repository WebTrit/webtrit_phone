import 'package:equatable/equatable.dart';
import 'package:webtrit_phone/app/constants.dart';

class AdapterInfo with EquatableMixin {
  AdapterInfo({this.name, this.version, this.supported, this.custom});

  final String? name;
  final String? version;
  final List<String>? supported;
  final Map<String, dynamic>? custom;

  @override
  List<Object?> get props => [name, version, supported, custom];

  @override
  bool get stringify => true;

  bool get supportsSipPresence => supported?.contains(kSipPresenceFeatureFlag) ?? false;

  bool get supportsSipDialogs => supported?.contains(kSipDialogsFeatureFlag) ?? false;

  /// Raw OTP login identifiers advertised by the backend adapter under
  /// `custom.otp_login_identifiers` (e.g. `phone_number`, `email`).
  ///
  /// Returns an empty list when the field is absent or malformed, letting
  /// callers fall back to their own default set.
  List<String> get otpLoginIdentifiers {
    final value = custom?[kOtpLoginIdentifiersCustomKey];
    if (value is! List) return const [];
    return value.whereType<String>().toList(growable: false);
  }
}
