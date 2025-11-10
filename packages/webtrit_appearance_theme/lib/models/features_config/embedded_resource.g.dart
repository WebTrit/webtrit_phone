// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'embedded_resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmbeddedResource _$EmbeddedResourceFromJson(
  Map<String, dynamic> json,
) => EmbeddedResource(
  id: const IntToStringConverter().fromJson(json['id']),
  uri: json['uri'] as String,
  type:
      $enumDecodeNullable(_$EmbeddedResourceTypeEnumMap, json['type']) ??
      EmbeddedResourceType.unknown,
  attributes: json['attributes'] as Map<String, dynamic>? ?? const {},
  toolbar: json['toolbar'] == null
      ? const ToolbarConfig()
      : ToolbarConfig.fromJson(json['toolbar'] as Map<String, dynamic>),
  metadata: json['metadata'] == null
      ? const Metadata()
      : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
  payload:
      (json['payload'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  enableConsoleLogCapture: json['enableConsoleLogCapture'] as bool? ?? false,
  reconnectStrategy: json['reconnectStrategy'] as String?,
);

Map<String, dynamic> _$EmbeddedResourceToJson(EmbeddedResource instance) =>
    <String, dynamic>{
      'id': const IntToStringConverter().toJson(instance.id),
      'uri': instance.uri,
      'type': _$EmbeddedResourceTypeEnumMap[instance.type]!,
      'attributes': instance.attributes,
      'toolbar': instance.toolbar.toJson(),
      'metadata': instance.metadata.toJson(),
      'payload': instance.payload,
      'enableConsoleLogCapture': instance.enableConsoleLogCapture,
      'reconnectStrategy': instance.reconnectStrategy,
    };

const _$EmbeddedResourceTypeEnumMap = {
  EmbeddedResourceType.terms: 'terms',
  EmbeddedResourceType.unknown: 'unknown',
};

ToolbarConfig _$ToolbarConfigFromJson(Map<String, dynamic> json) =>
    ToolbarConfig(
      titleL10n: json['titleL10n'] as String?,
      showToolbar: json['showToolbar'] as bool? ?? false,
    );

Map<String, dynamic> _$ToolbarConfigToJson(ToolbarConfig instance) =>
    <String, dynamic>{
      'titleL10n': instance.titleL10n,
      'showToolbar': instance.showToolbar,
    };
