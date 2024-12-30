import 'package:freezed_annotation/freezed_annotation.dart';

part 'self_config.freezed.dart';

part 'self_config.g.dart';

@freezed
@Deprecated('Replaced by custom pages response')
class SelfConfigResponse with _$SelfConfigResponse {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SelfConfigResponse({
    required Uri url,
    required DateTime expiresAt,
  }) = _SelfConfigResponse;

  factory SelfConfigResponse.fromJson(Map<String, Object?> json) => _$SelfConfigResponseFromJson(json);
}
