// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'session_response.dart';

part 'session_authorized_response.freezed.dart';

part 'session_authorized_response.g.dart';

@freezed
class SessionAuthorizedResponse with _$SessionAuthorizedResponse implements BaseSessionResponse {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SessionAuthorizedResponse({
    required String token,
    required String expiresAt,
    String? tenantId,
  }) = _SessionAuthorizedResponse;

  factory SessionAuthorizedResponse.fromJson(Map<String, dynamic> json) => _$SessionAuthorizedResponseFromJson(json);
}
