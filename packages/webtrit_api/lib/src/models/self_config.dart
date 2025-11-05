import 'package:freezed_annotation/freezed_annotation.dart';

part 'self_config.freezed.dart';

part 'self_config.g.dart';

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SelfConfigResponse with _$SelfConfigResponse {
  const SelfConfigResponse({required this.url, required this.expiresAt});

  @override
  final Uri url;

  @override
  final DateTime expiresAt;

  factory SelfConfigResponse.fromJson(Map<String, Object?> json) => _$SelfConfigResponseFromJson(json);

  Map<String, Object?> toJson() => _$SelfConfigResponseToJson(this);
}
