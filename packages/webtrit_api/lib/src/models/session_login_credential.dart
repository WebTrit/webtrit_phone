// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_type.dart';

part 'session_login_credential.freezed.dart';

part 'session_login_credential.g.dart';

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SessionLoginCredential with _$SessionLoginCredential {
  const SessionLoginCredential({
    this.bundleId,
    required this.type,
    required this.identifier,
    required this.login,
    required this.password,
  });

  @override
  final String? bundleId;

  @override
  final AppType type;

  @override
  final String identifier;

  @override
  final String login;

  @override
  final String password;

  factory SessionLoginCredential.fromJson(Map<String, dynamic> json) => _$SessionLoginCredentialFromJson(json);

  Map<String, dynamic> toJson() => _$SessionLoginCredentialToJson(this);
}
