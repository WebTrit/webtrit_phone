// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_type.dart';

part 'session_login_credential.freezed.dart';

part 'session_login_credential.g.dart';

@freezed
class SessionLoginCredential with _$SessionLoginCredential {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SessionLoginCredential({
    required AppType type,
    required String identifier,
    required String login,
    required String password,
  }) = _SessionLoginCredential;

  factory SessionLoginCredential.fromJson(Map<String, dynamic> json) => _$SessionLoginCredentialFromJson(json);
}
