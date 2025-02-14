// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'embedded_resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmbeddedResourceImpl _$$EmbeddedResourceImplFromJson(
        Map<String, dynamic> json) =>
    _$EmbeddedResourceImpl(
      id: (json['id'] as num?)?.toInt(),
      resource: json['resource'] as String,
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
      'resource': instance.resource,
      'attributes': instance.attributes,
      'toolbar': instance.toolbar.toJson(),
      'metadata': instance.metadata.toJson(),
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
