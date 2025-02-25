// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'embedded_resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmbeddedResourceImpl _$$EmbeddedResourceImplFromJson(
        Map<String, dynamic> json) =>
    _$EmbeddedResourceImpl(
      id: (json['id'] as num).toInt(),
      uri: json['uri'] as String,
      type: $enumDecodeNullable(_$EmbeddedResourceTypeEnumMap, json['type']) ??
          EmbeddedResourceType.unknown,
      attributes: json['attributes'] as Map<String, dynamic>? ?? const {},
      toolbar: json['toolbar'] == null
          ? const ToolbarConfig()
          : ToolbarConfig.fromJson(json['toolbar'] as Map<String, dynamic>),
      metadata: json['metadata'] == null
          ? const Metadata()
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$EmbeddedResourceImplToJson(
        _$EmbeddedResourceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uri': instance.uri,
      'type': _$EmbeddedResourceTypeEnumMap[instance.type]!,
      'attributes': instance.attributes,
      'toolbar': instance.toolbar.toJson(),
      'metadata': instance.metadata.toJson(),
    };

const _$EmbeddedResourceTypeEnumMap = {
  EmbeddedResourceType.terms: 'terms',
  EmbeddedResourceType.unknown: 'unknown',
};

_$ToolbarConfigImpl _$$ToolbarConfigImplFromJson(Map<String, dynamic> json) =>
    _$ToolbarConfigImpl(
      titleL10n: json['titleL10n'] as String?,
      showToolbar: json['showToolbar'] as bool? ?? false,
    );

Map<String, dynamic> _$$ToolbarConfigImplToJson(_$ToolbarConfigImpl instance) =>
    <String, dynamic>{
      'titleL10n': instance.titleL10n,
      'showToolbar': instance.showToolbar,
    };
