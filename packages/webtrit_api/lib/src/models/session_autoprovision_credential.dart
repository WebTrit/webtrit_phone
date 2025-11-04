// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_type.dart';

part 'session_autoprovision_credential.freezed.dart';

part 'session_autoprovision_credential.g.dart';

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SessionAutoProvisionCredential with _$SessionAutoProvisionCredential {
  const SessionAutoProvisionCredential({
    this.bundleId,
    required this.type,
    required this.identifier,
    required this.configToken,
  });

  @override
  final String? bundleId;

  @override
  final AppType type;

  @override
  final String identifier;

  @override
  final String configToken;

  factory SessionAutoProvisionCredential.fromJson(Map<String, dynamic> json) =>
      _$SessionAutoProvisionCredentialFromJson(json);

  Map<String, dynamic> toJson() => _$SessionAutoProvisionCredentialToJson(this);
}
