// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageSource _$ImageSourceFromJson(Map<String, dynamic> json) => ImageSource(
  id: json['id'] as String?,
  uri: json['uri'] as String?,
  ref: json[r'$ref'] as String? ?? 'asset',
  render: json['render'] == null
      ? null
      : ImageRenderSpec.fromJson(json['render'] as Map<String, dynamic>),
  metadata: json['metadata'] == null
      ? const Metadata()
      : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ImageSourceToJson(ImageSource instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uri': instance.uri,
      r'$ref': instance.ref,
      'render': instance.render?.toJson(),
      'metadata': instance.metadata.toJson(),
    };

ImageRenderSpec _$ImageRenderSpecFromJson(Map<String, dynamic> json) =>
    ImageRenderSpec(
      scale: (json['scale'] as num?)?.toDouble(),
      padding: json['padding'] == null
          ? null
          : PaddingConfig.fromJson(json['padding'] as Map<String, dynamic>),
      alignment: $enumDecodeNullable(
        _$AlignmentConfigEnumMap,
        json['alignment'],
        unknownValue: JsonKey.nullForUndefinedEnumValue,
      ),
      fit: $enumDecodeNullable(
        _$BoxFitConfigEnumMap,
        json['fit'],
        unknownValue: JsonKey.nullForUndefinedEnumValue,
      ),
    );

Map<String, dynamic> _$ImageRenderSpecToJson(ImageRenderSpec instance) =>
    <String, dynamic>{
      'scale': instance.scale,
      'padding': instance.padding?.toJson(),
      'alignment': _$AlignmentConfigEnumMap[instance.alignment],
      'fit': _$BoxFitConfigEnumMap[instance.fit],
    };

const _$AlignmentConfigEnumMap = {
  AlignmentConfig.topLeft: 'topLeft',
  AlignmentConfig.topCenter: 'topCenter',
  AlignmentConfig.topRight: 'topRight',
  AlignmentConfig.centerLeft: 'centerLeft',
  AlignmentConfig.center: 'center',
  AlignmentConfig.centerRight: 'centerRight',
  AlignmentConfig.bottomLeft: 'bottomLeft',
  AlignmentConfig.bottomCenter: 'bottomCenter',
  AlignmentConfig.bottomRight: 'bottomRight',
};

const _$BoxFitConfigEnumMap = {
  BoxFitConfig.fill: 'fill',
  BoxFitConfig.contain: 'contain',
  BoxFitConfig.cover: 'cover',
  BoxFitConfig.fitWidth: 'fitWidth',
  BoxFitConfig.fitHeight: 'fitHeight',
  BoxFitConfig.none: 'none',
  BoxFitConfig.scaleDown: 'scaleDown',
};
