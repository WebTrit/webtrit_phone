import 'package:freezed_annotation/freezed_annotation.dart';

import '../color/color_dto.dart';
import '../image/image_collection_dto.dart';
import '../texts/texts_dto.dart';

part 'theme_dto.freezed.dart';

part 'theme_dto.g.dart';

toNull(_) => null;

@Freezed(makeCollectionsUnmodifiable: false)
class ThemeDTO with _$ThemeDTO {
  const factory ThemeDTO({
    String? id,
    String? name,
    String? fontFamily,
    ImageCollectionDTO? images,
    ColorDTO? colors,
    TextsDTO? texts,
  }) = _ThemeDTO;

  factory ThemeDTO.fromJson(Map<String, Object?> json) => _$ThemeDTOFromJson(json);
}
