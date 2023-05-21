// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ColorDTO _$$_ColorDTOFromJson(Map<String, dynamic> json) => _$_ColorDTO(
      primary: json['primary'] as String?,
      onPrimary: json['onPrimary'] as String?,
      secondary: json['secondary'] as String?,
      secondaryContainer: json['secondaryContainer'] as String?,
      onSecondaryContainer: json['onSecondaryContainer'] as String?,
      tertiary: json['tertiary'] as String?,
      error: json['error'] as String?,
      outline: json['outline'] as String?,
      background: json['background'] as String?,
      onBackground: json['onBackground'] as String?,
      surface: json['surface'] as String?,
      onSurface: json['onSurface'] as String?,
      gradientTabColor: (json['gradientTabColor'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_ColorDTOToJson(_$_ColorDTO instance) =>
    <String, dynamic>{
      'primary': instance.primary,
      'onPrimary': instance.onPrimary,
      'secondary': instance.secondary,
      'secondaryContainer': instance.secondaryContainer,
      'onSecondaryContainer': instance.onSecondaryContainer,
      'tertiary': instance.tertiary,
      'error': instance.error,
      'outline': instance.outline,
      'background': instance.background,
      'onBackground': instance.onBackground,
      'surface': instance.surface,
      'onSurface': instance.onSurface,
      'gradientTabColor': instance.gradientTabColor,
    };
