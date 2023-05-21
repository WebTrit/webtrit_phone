// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ThemeDTO _$$_ThemeDTOFromJson(Map<String, dynamic> json) => _$_ThemeDTO(
      id: json['id'] as String?,
      name: json['name'] as String?,
      fontFamily: json['fontFamily'] as String?,
      images: json['images'] == null
          ? null
          : ImageCollectionDTO.fromJson(json['images'] as Map<String, dynamic>),
      colors: json['colors'] == null
          ? null
          : ColorDTO.fromJson(json['colors'] as Map<String, dynamic>),
      texts: json['texts'] == null
          ? null
          : TextsDTO.fromJson(json['texts'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ThemeDTOToJson(_$_ThemeDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'fontFamily': instance.fontFamily,
      'images': instance.images,
      'colors': instance.colors,
      'texts': instance.texts,
    };
