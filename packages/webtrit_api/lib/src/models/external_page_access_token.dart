// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'external_page_access_token.freezed.dart';

part 'external_page_access_token.g.dart';

@freezed
class ExternalPageAccessToken with _$ExternalPageAccessToken {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ExternalPageAccessToken({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'refresh_token') required String refreshToken,
    @JsonKey(name: 'expires_at') required DateTime expiresAt,
  }) = _ExternalPageAccessToken;

  factory ExternalPageAccessToken.fromJson(Map<String, Object?> json) => _$ExternalPageAccessTokenFromJson(json);
}
