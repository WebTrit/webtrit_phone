// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_type.dart';

part 'user_action_credential.freezed.dart';

part 'user_action_credential.g.dart';

@freezed
class UserActionCredential with _$UserActionCredential {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UserActionCredential({
    required AppType type,
    required String identifier,
    required String email,
    required String tenantId,
    required String action,
  }) = _UserActionCredential;

  factory UserActionCredential.fromJson(Map<String, dynamic> json) => _$UserActionCredentialFromJson(json);
}
