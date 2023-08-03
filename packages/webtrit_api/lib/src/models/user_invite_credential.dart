// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_type.dart';

part 'user_invite_credential.freezed.dart';

part 'user_invite_credential.g.dart';

@freezed
class UserInviteCredential with _$UserInviteCredential {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UserInviteCredential({
    required AppType type,
    required String identifier,
    required String email,
    required String tenantId,
    required String action,
  }) = _UserInviteCredential;

  factory UserInviteCredential.fromJson(Map<String, dynamic> json) => _$UserInviteCredentialFromJson(json);
}
