import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_pages.freezed.dart';
part 'custom_pages.g.dart';

@freezed
class CustomPagesResponse with _$CustomPagesResponse {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CustomPagesResponse({
    required List<CustomPageResponse> pages,
  }) = _CustomPagesResponse;

  factory CustomPagesResponse.fromJson(Map<String, Object?> json) => _$CustomPagesResponseFromJson(json);
}

@freezed
class CustomPageResponse with _$CustomPageResponse {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CustomPageResponse({
    required String title,
    required Uri url,
    required Map<String, dynamic> extraData,
    required String? description,
    required DateTime? expiresAt,
  }) = _CustomPageResponse;

  factory CustomPageResponse.fromJson(Map<String, Object?> json) => _$CustomPageResponseFromJson(json);
}
