// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_type.dart';

part 'session_user_credential_number.freezed.dart';

part 'session_user_credential_number.g.dart';

@freezed
class SessionUserCredentialNumber with _$SessionUserCredentialNumber {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SessionUserCredentialNumber({
    String? bundleId,
    required AppType type,
    required String identifier,
    required String phoneNumber,
  }) = _SessionUserCredentialNumber;

  factory SessionUserCredentialNumber.fromJson(Map<String, dynamic> json) => _$SessionUserCredentialNumberFromJson(json);
}
