// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_type.dart';

part 'session_user_credential.freezed.dart';

part 'session_user_credential.g.dart';

@freezed
class SessionUserCredential with _$SessionUserCredential {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SessionUserCredential({
    required AppType type,
    required String identifier,
    required String email,
  }) = _SessionUserCredential;

  factory SessionUserCredential.fromJson(Map<String, dynamic> json) => _$SessionUserCredentialFromJson(json);
}
