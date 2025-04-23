import 'package:freezed_annotation/freezed_annotation.dart';

part 'external_page_access_token.freezed.dart';

part 'external_page_access_token.g.dart';

@freezed
class ExternalPageAccessToken with _$ExternalPageAccessToken {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ExternalPageAccessToken({
    required String token,
    required DateTime expiresAt,
  }) = _ExternalPageAccessToken;

  factory ExternalPageAccessToken.fromJson(Map<String, Object?> json) => _$ExternalPageAccessTokenFromJson(json);
}
