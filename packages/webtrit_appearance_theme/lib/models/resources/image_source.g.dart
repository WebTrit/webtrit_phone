// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ImageSourceImpl _$$ImageSourceImplFromJson(Map<String, dynamic> json) =>
    _$ImageSourceImpl(
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

Map<String, dynamic> _$$ImageSourceImplToJson(_$ImageSourceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uri': instance.uri,
      r'$ref': instance.ref,
      'render': instance.render,
      'metadata': instance.metadata,
    };

_$ImageRenderSpecImpl _$$ImageRenderSpecImplFromJson(
        Map<String, dynamic> json) =>
    _$ImageRenderSpecImpl(
      scale: (json['scale'] as num?)?.toDouble(),
      padding: json['padding'] == null
          ? null
          : PaddingConfig.fromJson(json['padding'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ImageRenderSpecImplToJson(
        _$ImageRenderSpecImpl instance) =>
    <String, dynamic>{
      'scale': instance.scale,
      'padding': instance.padding,
    };
