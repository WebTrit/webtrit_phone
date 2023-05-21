import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_dto.freezed.dart';

part 'image_dto.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class ImageDTO with _$ImageDTO {
  const factory ImageDTO({
    String? data,
    String? name,
    String? mime,
    String? extension,
  }) = _ImageDTO;

  factory ImageDTO.fromJson(Map<String, Object?> json) => _$ImageDTOFromJson(json);
}
