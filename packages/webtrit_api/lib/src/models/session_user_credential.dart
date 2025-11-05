// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_type.dart';

part 'session_user_credential.freezed.dart';

part 'session_user_credential.g.dart';

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SessionUserCredential with _$SessionUserCredential {
  const SessionUserCredential(
      {this.bundleId,
      required this.type,
      required this.identifier,
      this.email});

  @override
  final String? bundleId;

  @override
  final AppType type;

  @override
  final String identifier;

  @override
  final String? email;

  factory SessionUserCredential.fromJson(Map<String, dynamic> json) =>
      _$SessionUserCredentialFromJson(json);

  Map<String, dynamic> toJson() => _$SessionUserCredentialToJson(this);
}
