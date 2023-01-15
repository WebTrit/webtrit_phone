// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_type.dart';

part 'session_otp_credential_demo.freezed.dart';

part 'session_otp_credential_demo.g.dart';

@freezed
class SessionOtpCredentialDemo with _$SessionOtpCredentialDemo {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SessionOtpCredentialDemo({
    required AppType type,
    required String identifier,
    required String email,
  }) = _SessionOtpCredentialDemo;

  factory SessionOtpCredentialDemo.fromJson(Map<String, dynamic> json) => _$SessionOtpCredentialDemoFromJson(json);
}
