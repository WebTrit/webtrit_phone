// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'external_page_access_token.freezed.dart';

part 'external_page_access_token.g.dart';

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ExternalPageAccessToken with _$ExternalPageAccessToken {
  const ExternalPageAccessToken({
    @JsonKey(name: 'access_token') required this.accessToken,
    @JsonKey(name: 'refresh_token') required this.refreshToken,
    @JsonKey(name: 'expires_at') required this.expiresAt,
  });

  @override
  @JsonKey(name: 'access_token')
  final String accessToken;

  @override
  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  @override
  @JsonKey(name: 'expires_at')
  final DateTime expiresAt;

  factory ExternalPageAccessToken.fromJson(Map<String, Object?> json) =>
      _$ExternalPageAccessTokenFromJson(json);

  Map<String, Object?> toJson() => _$ExternalPageAccessTokenToJson(this);
}
