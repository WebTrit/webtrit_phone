// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_type.dart';

part 'user_signup_credentials.freezed.dart';

part 'user_signup_credentials.g.dart';

@freezed
class UserSignupCredentials with _$UserSignupCredentials {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UserSignupCredentials({
    required AppType type,
    required String identifier,
    required String email,
  }) = _UserSignupCredentials;

  factory UserSignupCredentials.fromJson(Map<String, dynamic> json) => _$_UserSignupCredentials.fromJson(json);
}
