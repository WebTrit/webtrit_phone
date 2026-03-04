// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blurred_surface_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BlurredSurfaceConfig _$BlurredSurfaceConfigFromJson(
  Map<String, dynamic> json,
) => _BlurredSurfaceConfig(
  color: json['color'] as String?,
  sigmaX: (json['sigmaX'] as num?)?.toDouble(),
  sigmaY: (json['sigmaY'] as num?)?.toDouble(),
);

Map<String, dynamic> _$BlurredSurfaceConfigToJson(
  _BlurredSurfaceConfig instance,
) => <String, dynamic>{
  'color': instance.color,
  'sigmaX': instance.sigmaX,
  'sigmaY': instance.sigmaY,
};
