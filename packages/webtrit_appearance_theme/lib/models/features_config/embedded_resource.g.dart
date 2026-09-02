// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'embedded_resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmbeddedResource _$EmbeddedResourceFromJson(
  Map<String, dynamic> json,
) => EmbeddedResource(
  id: json['id'] as String,
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
      'id': instance.id,
      'uri': instance.uri,
      'type': _$EmbeddedResourceTypeEnumMap[instance.type]!,
      'attributes': instance.attributes,
      'toolbar': instance.toolbar.toJson(),
      'metadata': instance.metadata.toJson(),
      'payload': instance.payload,
      'enableConsoleLogCapture': instance.enableConsoleLogCapture,
      'reconnectStrategy': instance.reconnectStrategy,
    };

const _$EmbeddedResourceJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'id': {
      'type': 'string',
      'description': 'Unique identifier for this resource.',
    },
    'uri': {
      'type': 'string',
      'description': 'The URI that points to the embedded resource.',
    },
    'type': {
      'type': 'object',
      'description': 'The type of the resource (e.g., web, file, etc.).',
    },
    'attributes': {
      'type': 'object',
      'additionalProperties': {'type': 'object'},
      'description':
          'Optional key–value attributes associated with the resource.',
      'default': {},
    },
    'toolbar': {
      r'$ref': r'#/$defs/ToolbarConfig',
      'description': 'Toolbar configuration for the resource.',
    },
    'metadata': {
      r'$ref': r'#/$defs/Metadata',
      'description': 'Metadata attached to this resource.',
    },
    'payload': {
      'type': 'array',
      'items': {'type': 'string'},
      'description': 'Optional payload data to pass to the embedded resource.',
      'default': [],
    },
    'enableConsoleLogCapture': {
      'type': 'boolean',
      'description':
          'Whether to capture `console.*` logs from inside the WebView.',
      'default': false,
    },
    'reconnectStrategy': {
      'type': 'string',
      'description': 'Strategy applied when network reconnects.',
    },
  },
  'required': ['id', 'uri'],
  r'$defs': {
    'ToolbarConfig': {
      'type': 'object',
      'properties': {
        'titleL10n': {
          'type': 'string',
          'description': 'The localized title for the toolbar.',
        },
        'showToolbar': {
          'type': 'boolean',
          'description': 'Whether the toolbar should be visible.',
          'default': false,
        },
      },
    },
    'Metadata': {
      'type': 'object',
      'properties': {
        'attributes': {
          'type': 'object',
          'additionalProperties': {'type': 'object'},
          'description':
              'A map storing arbitrary key-value pairs for contextual or configuration data.',
          'default': {},
        },
      },
    },
  },
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
