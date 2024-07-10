// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../app_type.dart';

part 'demo_credential.freezed.dart';

part 'demo_credential.g.dart';

@freezed
class DemoCredential with _$DemoCredential {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DemoCredential({
    required AppType type,
    required String identifier,
    required String email,
    required String tenantId,
    required String action,
  }) = _DemoCredential;

  factory DemoCredential.fromJson(Map<String, dynamic> json) => _$DemoCredentialFromJson(json);
}
