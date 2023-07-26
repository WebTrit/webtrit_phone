// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_type.dart';

part 'session_otp_credential.freezed.dart';

part 'session_otp_credential.g.dart';

@freezed
class SessionOtpCredential with _$SessionOtpCredential {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SessionOtpCredential({
    required String bundleId,
    required AppType type,
    required String identifier,
    required String userRef,
  }) = _SessionOtpCredential;

  factory SessionOtpCredential.fromJson(Map<String, dynamic> json) => _$SessionOtpCredentialFromJson(json);
}
