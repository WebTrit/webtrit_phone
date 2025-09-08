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
      metadata: json['metadata'] == null
          ? const Metadata()
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ImageSourceImplToJson(_$ImageSourceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uri': instance.uri,
      r'$ref': instance.ref,
      'metadata': instance.metadata,
    };
