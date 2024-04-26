// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_type.dart';

part 'session_autoprovision_credential.freezed.dart';

part 'session_autoprovision_credential.g.dart';

@freezed
class SessionAutoProvisionCredential with _$SessionAutoProvisionCredential {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SessionAutoProvisionCredential({
    String? bundleId,
    required AppType type,
    required String identifier,
    required String configToken,
  }) = _SessionAutoProvisionCredential;

  factory SessionAutoProvisionCredential.fromJson(Map<String, dynamic> json) =>
      _$SessionAutoProvisionCredentialFromJson(json);
}
