import 'package:freezed_annotation/freezed_annotation.dart';

part 'texts_dto.freezed.dart';

part 'texts_dto.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class TextsDTO with _$TextsDTO {
  const factory TextsDTO({
    String? greeting,
    String? contact_email,
  }) = _TextsDTO;

  factory TextsDTO.fromJson(Map<String, Object?> json) => _$TextsDTOFromJson(json);
}
