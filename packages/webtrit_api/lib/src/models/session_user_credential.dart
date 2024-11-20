// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_type.dart';

part 'session_user_credential.freezed.dart';

part 'session_user_credential.g.dart';

@freezed
class SessionUserCredential with _$SessionUserCredential {
  // Private main constructor
  const SessionUserCredential._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SessionUserCredential._internal({
    String? bundleId,
    required AppType type,
    required String identifier,
    String? email,
    String? phoneNumber,
  }) = _SessionUserCredential;

  /// Public factory for creating an object with an email
  factory SessionUserCredential.withEmail({
    String? bundleId,
    required AppType type,
    required String identifier,
    required String email,
  }) =>
      SessionUserCredential._internal(
        bundleId: bundleId,
        type: type,
        identifier: identifier,
        email: email,
        phoneNumber: null,
      );

  /// Public factory for creating an object with a phone number
  factory SessionUserCredential.withPhoneNumber({
    String? bundleId,
    required AppType type,
    required String identifier,
    required String phoneNumber,
  }) =>
      SessionUserCredential._internal(
        bundleId: bundleId,
        type: type,
        identifier: identifier,
        email: null,
        phoneNumber: phoneNumber,
      );

  factory SessionUserCredential.fromJson(Map<String, dynamic> json) => _$SessionUserCredentialFromJson(json);
}
